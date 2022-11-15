import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/auth/auth_page.dart';
import 'package:moneymanager/pages/login_page.dart';

import '../pages/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({ Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return AuthPage();
            }
          },
        )
      );
    }
  }