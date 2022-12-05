import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/data/transactionObject.dart';
import 'package:moneymanager/pages/tabs/home_page_tab.dart';
import 'package:moneymanager/pages/tabs/module_page_tab.dart';
import 'package:moneymanager/pages/tabs/profile_tab.dart';
import 'package:moneymanager/pages/registration_signup/survey.dart';
import 'package:moneymanager/data/user.dart';
import 'package:moneymanager/pages/tabs/visualize_tab.dart';
import 'package:moneymanager/utils/colors.dart';
import 'package:moneymanager/utils/constants.dart';

// Home Page Host
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var rebuildbasic = true;
  var rebuildFull = true;

  var currentIndex = 0;

  Future transactionBuilder() async {
    List<TransactionObject> transactionList = [];
    for (int i = 0; i < CurrentUser.transactions.length; i++) {
      var map = Map<String, dynamic>.from(CurrentUser.getTransactions[i]);
      transactionList.add(TransactionObject.decoded(map));
    }
    CurrentUser.setTransctionObjectList = transactionList;
  }

  // Navbar Method
  Widget buildContentOfTab(int index) {
    switch (index) {
      case 0:
        return const HomePageTab();
      case 1:
        return const ModulePage();
      case 2:
        return const VisualizePage();
      case 3:
        return const ProfileTab();

      default:
        return const HomePageTab();
    }
  }

  @override
  void initState() {}

  // Obtain user details from Firestore on first load.
  Future fillUserDetails() async {
    CurrentUser.firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('users')
        .doc(CurrentUser.firebaseUser?.uid)
        .get();
    CurrentUser.setFirstName = data.get('first name');
    CurrentUser.setLastName = data.get('last name');
    CurrentUser.setEmail = data.get('email');
    CurrentUser.setCode = data.get('sign up code');
    CurrentUser.setAccountType = data.get('account type');
    CurrentUser.setSurveyStatus = data.get('survey completed');
    CurrentUser.setTransactions = data.get('transactions') as List;

    await transactionBuilder();
    CurrentUser.updateUserIncomeAndExpense();
    CurrentUser.updateTotalBalance();
    CurrentUser.parseTransactionsMonthly();
    CurrentUser.parseExpensesMonthly();
  }

  // Fills advanced information about the user from the database, generally only after survey is complete.
  Future fillFullUserDetails() async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('users')
        .doc(CurrentUser.firebaseUser?.uid)
        .get();
    CurrentUser.setAge = data.get('age');
    CurrentUser.setExperience = data.get('experience');
    CurrentUser.setWeeklyEarning = double.parse(data.get('weekly income'));
    CurrentUser.setWeeklySpending = double.parse(data.get('weekly spending'));
    CurrentUser.setSurveyStatus = data.get('survey completed');

    if (CurrentUser.getAccountType == "Parent") {
      CurrentUser.updateConnectedUsers();
    }
  }

  Future checkAndFillDetails() async {
    if (rebuildbasic) {
      await fillUserDetails();
      rebuildbasic = false;

      if (CurrentUser.getSurveyStatus == false) {
        Future.delayed(Duration.zero, () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Survey()));
        });
      } else {
        await fillFullUserDetails();
        rebuildFull = false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkAndFillDetails(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == true) {
            return Scaffold(
              body: buildContentOfTab(currentIndex),
              bottomNavigationBar: BottomNavigationBar(
                showUnselectedLabels: false,
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                selectedItemColor: AppColor.customLightGreen,
                unselectedItemColor: fontLight,
                items: [
                  BottomNavigationBarItem(
                      icon: Image.asset('assets/icons/home-1.png'),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon: Image.asset('assets/icons/book.png'),
                      label: "Lessons"),
                  BottomNavigationBarItem(
                      icon: Image.asset('assets/icons/chart-vertical.png'),
                      label: "Data"),
                  BottomNavigationBarItem(
                      icon: Image.asset('assets/icons/user-1.png'),
                      label: "Profile"),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
