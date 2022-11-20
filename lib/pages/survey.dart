import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

// Page for survey that is completed upon user sign up.
class Survey extends StatefulWidget {
  const Survey({super.key});

  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center (
          child: SingleChildScrollView(
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('SURVEY')
              ]
            )
          )
        )
      )
    );
  }
}