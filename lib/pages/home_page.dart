import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/pages/survey.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:moneymanager/user.dart';

// Main Page
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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

  Future getDB() async {
     DatabaseReference ref = FirebaseDatabase.instance.ref('Modules/');
    
    // Get the data once
      DatabaseEvent event = await ref.once();

      // Print the data of the snapshot
      print(event.snapshot.value);
  }

  // Obtain user details from Firestore.
  Future fillBasicUserDetails() async {
    CurrentUser.firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot data = await FirebaseFirestore.instance.collection('users').doc(CurrentUser.firebaseUser?.uid).get();
    CurrentUser.setFirstName = data.get('first name');
    CurrentUser.setLastName = data.get('last name');
    CurrentUser.setCode = data.get('sign up code');
    CurrentUser.setSurveyStatus = data.get('survey completed');

    // If survey has not been completed push the user to the survey.
    if (CurrentUser.getSurveyStatus == false) {
        Future.delayed(Duration.zero, () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => const Survey()));
        }
      );
    }
  }

  // Fills advanced information about the user from the database.
  Future fillFullUserDetails() async {
    DocumentSnapshot data = await FirebaseFirestore.instance.collection('users').doc(CurrentUser.firebaseUser?.uid).get();
    CurrentUser.setAge = data.get('age');
    CurrentUser.setExperience = data.get('experience');
    CurrentUser.setWeeklyEarning = double.parse(data.get('weekly income'));
    CurrentUser.setWeeklySpending = double.parse(data.get('weekly spending'));
    CurrentUser.setSurveyStatus = data.get('survey completed');
  }

  Future checkForSurvey() async{
    return CurrentUser.getSurveyStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Signed In As ${CurrentUser.firebaseUser?.email}'),
          MaterialButton(onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          color: Colors.blue,
          child: Text('Sign Out'),
          )
        ],
      )),
    );
  }
}

