import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moneymanager/auth/main_page.dart';
import 'package:moneymanager/pages/login_page.dart';
import 'package:moneymanager/pages/calculator_page.dart';
import 'package:moneymanager/pages/register_page.dart';
import 'package:moneymanager/pages/survey.dart';
import 'package:moneymanager/pages/visualize_page.dart';
import 'package:fl_chart/fl_chart.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VisualizePage(),
    );
  }
}
