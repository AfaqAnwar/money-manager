import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/pages/survey.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:moneymanager/user.dart';

// Main Page
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  // Initially checks for survey completion to ensure proper data is present.
  @override
  void initState() {
    
  }    
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    )

  }
}

