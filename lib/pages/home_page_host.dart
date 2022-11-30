import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/data/transactionObject.dart';
import 'package:moneymanager/pages/home_page_tab.dart';
import 'package:moneymanager/pages/profile_tab.dart';
import 'package:moneymanager/pages/survey.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:moneymanager/data/user.dart';
import 'package:moneymanager/utils/constants.dart';

// Home Page Host
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  // Navbar Method
  Widget buildContentOfTab(int index) {
    switch (index) {
      case 0:
        return const HomePageTab();
      case 1:
        return Container();
      case 2:
        return Container();
      case 3:
        return const ProfileTab();

      default:
        return const HomePageTab();
    }
  }

  // Initially checks for survey completion to ensure proper data is present.
  @override
  void initState() {
    fillBasicUserDetails();

    try {
      fillFullUserDetails();
    } catch (e) {
      print("User Information Error");
    }
  }

  // Import Firebase Realtime Database
  Future getDB() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('Modules/');
    // Get the data once
    DatabaseEvent event = await ref.once();
  }

  // Obtain user details from Firestore.
  Future fillBasicUserDetails() async {
    CurrentUser.firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('users')
        .doc(CurrentUser.firebaseUser?.uid)
        .get();
    CurrentUser.setFirstName = data.get('first name');
    CurrentUser.setLastName = data.get('last name');
    CurrentUser.setCode = data.get('sign up code');
    CurrentUser.setSurveyStatus = data.get('survey completed');

    // If survey has not been completed push the user to the survey.
    if (CurrentUser.getSurveyStatus == false) {
      Future.delayed(Duration.zero, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Survey()));
      });
    }
  }

  // Fills advanced information about the user from the database.
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
    CurrentUser.setTransactions = data.get('transactions') as List;
  }

  Future checkForSurvey() async {
    return CurrentUser.getSurveyStatus;
  }

  @override
  Widget build(BuildContext context) {
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
        selectedItemColor: secondaryDark,
        unselectedItemColor: fontLight,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/home-1.png'), label: "Home"),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/book.png'), label: "Lessons"),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/chart-vertical.png'),
              label: "Data"),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/user-1.png'), label: "Profile"),
        ],
      ),
    );
  }
}
