// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moneymanager/pages/lesson_goal_page.dart';
import 'package:moneymanager/pages/lesson_page.dart';
import 'package:moneymanager/auth/main_page.dart';
import 'package:moneymanager/pages/module_page.dart';
import 'package:moneymanager/pages/lesson_goal_page.dart';
import 'package:moneymanager/pages/quiz_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ignore: prefer_const_constructors
      home: QuizPage(),
    );
  }
}