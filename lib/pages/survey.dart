import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneymanager/pages/home_page_host.dart';
import 'package:moneymanager/data/user.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Survey Page
class Survey extends StatefulWidget {
  const Survey({super.key});

  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Align(
            alignment: Alignment.center,
            child: FutureBuilder<Task>(
              future: getMoneySurvey(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  final task = snapshot.data!;
                  return SurveyKit(
                    onResult: (SurveyResult result) {
                      try {
                        DocumentReference ref = FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid);
                        // result.results contains a list of the instances of steps. [0] is negligible since it's the instruction step.
                        ref.update({
                          'age': int.parse(
                              result.results[1].results[0].result.toString()),
                          'experience':
                              result.results[2].results[0].result.value,
                          'weekly income':
                              result.results[3].results[0].result.toString(),
                          'weekly spending':
                              result.results[4].results[0].result.toString(),
                          'survey completed': true,
                        });

                        CurrentUser.setAge = int.parse(
                            result.results[1].results[0].result.toString());
                        CurrentUser.setExperience =
                            result.results[2].results[0].result.value;
                        CurrentUser.setWeeklyEarning = double.parse(
                            result.results[3].results[0].result.toString());
                        CurrentUser.setWeeklySpending = double.parse(
                            result.results[4].results[0].result.toString());
                        CurrentUser.setSurveyStatus = true;

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      } catch (e) {
                        // Survey is mandatory and thus cannot be cancelled.
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Whoops'),
                                  content: Text(
                                      'You have to complete this survey before proceeding.'),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Survey())),
                                        child: Text('Got It')),
                                  ],
                                ));
                      }
                    },
                    task: task,
                    showProgress: true,
                    localizations: {
                      'next': 'Next',
                    },
                    themeData: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.fromSwatch(
                        primarySwatch: Colors.cyan,
                      ).copyWith(
                        onPrimary: Colors.white,
                      ),
                      primaryColor: Colors.cyan,
                      backgroundColor: Colors.white,
                      appBarTheme: const AppBarTheme(
                        color: Colors.white,
                        iconTheme: IconThemeData(
                          color: Colors.cyan,
                        ),
                        titleTextStyle: TextStyle(
                          color: Colors.cyan,
                        ),
                      ),
                      iconTheme: const IconThemeData(
                        color: Colors.cyan,
                      ),
                      textSelectionTheme: TextSelectionThemeData(
                        cursorColor: Colors.cyan,
                        selectionColor: Colors.cyan,
                        selectionHandleColor: Colors.cyan,
                      ),
                      cupertinoOverrideTheme: CupertinoThemeData(
                        primaryColor: Colors.cyan,
                      ),
                      outlinedButtonTheme: OutlinedButtonThemeData(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            Size(150.0, 60.0),
                          ),
                          side: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> state) {
                              if (state.contains(MaterialState.disabled)) {
                                return BorderSide(
                                  color: Colors.grey,
                                );
                              }
                              return BorderSide(
                                color: Colors.cyan,
                              );
                            },
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          textStyle: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> state) {
                              if (state.contains(MaterialState.disabled)) {
                                return Theme.of(context)
                                    .textTheme
                                    .button
                                    ?.copyWith(
                                      color: Colors.grey,
                                    );
                              }
                              return Theme.of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(
                                    color: Colors.cyan,
                                  );
                            },
                          ),
                        ),
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                            Theme.of(context).textTheme.button?.copyWith(
                                  color: Colors.cyan,
                                ),
                          ),
                        ),
                      ),
                      textTheme: TextTheme(
                        headline2: TextStyle(
                          fontSize: 28.0,
                          color: Colors.black,
                        ),
                        headline5: TextStyle(
                          fontSize: 24.0,
                          color: Colors.black,
                        ),
                        bodyText2: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        subtitle1: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                      inputDecorationTheme: InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    surveyProgressbarConfiguration: SurveyProgressConfiguration(
                      backgroundColor: Colors.white,
                    ),
                  );
                }
                return CircularProgressIndicator.adaptive();
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<Task> getMoneySurvey() {
    var task = OrderedTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'Welcome to the\nMoney Manager\nMoney Survey',
          text:
              'Just to get started we will ask some simple questions to help understand your financials.',
          buttonText: 'Get Started',
        ),
        QuestionStep(
          title: 'How old are you?',
          answerFormat: IntegerAnswerFormat(
            defaultValue: 18,
            hint: 'Please enter your age',
          ),
          isOptional: false,
        ),
        QuestionStep(
            title: 'How familiar are you with saving & investing?',
            answerFormat: SingleChoiceAnswerFormat(textChoices: [
              TextChoice(text: 'Not Familiar', value: 'Not Familiar'),
              TextChoice(text: 'Somewhat Familiar', value: 'Somewhat Familiar'),
              TextChoice(text: 'Very Familiar', value: 'Very Familiar'),
              TextChoice(
                  text: 'Extremely Familiar', value: 'Extremely Familiar'),
            ])),
        QuestionStep(
          title: 'How much money do you earn per week?',
          text: 'This could be from allowances, work, etc.',
          answerFormat: IntegerAnswerFormat(
            defaultValue: 0,
            hint: '',
          ),
          isOptional: false,
        ),
        QuestionStep(
          title: 'How much money do you spend per week?',
          text: 'Give us your best estimate.',
          answerFormat: IntegerAnswerFormat(
            defaultValue: 0,
            hint: '',
          ),
          isOptional: false,
        ),
        CompletionStep(
          stepIdentifier: StepIdentifier(id: 'completed'),
          text:
              'Thanks for taking the survey, we\'ll get things set up for you!',
          title: 'Done!',
          buttonText: 'Finish Survey',
        ),
      ],
    );
    return Future.value(task);
  }
}
