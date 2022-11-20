import 'package:flutter/material.dart';
import 'package:moneymanager/pages/login_page.dart';
import 'package:moneymanager/pages/register_page.dart';

// Controlls if Login or Registration Page is Visible.
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
        showLoginPage = !showLoginPage;
    });
  }

  @override   
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreens);
    } else {
      return RegisterPage(showLoginPage: toggleScreens);
    }
  }
}