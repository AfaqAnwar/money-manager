
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager/auth/main_page.dart';
import 'package:moneymanager/utils/colors.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: GoogleFonts.sourceSansPro().fontFamily,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: AppColor.customLightGreen,
          )),
      home: const MainPage(),
    );
  }
}
