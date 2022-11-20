import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/pages/survey.dart';

// Main Page
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Current User Fields
  String firstName = "";
  String lastName = "";
  String signUpCode = "";
  bool surveyCompleted = false;

  final user = FirebaseAuth.instance.currentUser!;

  // Initially checks for survey completion to ensure proper data is present.
  @override
  void initState() {
    fillUserDetails();

    if (surveyCompleted == false) {
      // If survey has not been completed, force push user to survey.
      Future.delayed(Duration.zero, () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => const Survey()));
        }
      ); 
    }
  }    

  // Obtain user details from Firestore.
  Future fillUserDetails() async {
    DocumentSnapshot data = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    firstName = data.get('first name');
    lastName = data.get('last name');
    signUpCode = data.get('sign up code');
    surveyCompleted = data.get('survey completed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Signed In As ' + user.email!),
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

