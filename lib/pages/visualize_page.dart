import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/pages/survey.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:moneymanager/user.dart';

// Main Page
class VisualizePage extends StatefulWidget {
  const VisualizePage({Key? key}) : super(key: key);

  @override
  State<VisualizePage> createState() => VisualizePageState();
}

class VisualizePageState extends State<VisualizePage> {

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

