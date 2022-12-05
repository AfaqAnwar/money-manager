// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, prefer_typing_uninitialized_variables, unused_field
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager/utils/colors.dart' as color;
import 'package:moneymanager/data/module_items.dart';
import 'package:moneymanager/pages/helpers/lesson_goal_page.dart';
import 'package:moneymanager/pages/helpers/lesson_page.dart';

class ModulePage extends StatefulWidget {
  const ModulePage({Key? key}) : super(key: key);

  @override
  State<ModulePage> createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  List moduleItems = [];

  Future<void> readJson() async {
    WidgetsFlutterBinding.ensureInitialized();
    final String response =
        await rootBundle.loadString('assets/data/lessons.json');
    final data = await json.decode(response);
    moduleItems = data["Modules"];
  }

  @override
  void initState() {}

  Future waitForJson() async {
    await readJson();
    return true;
  }

// UI Design
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: waitForJson(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Modules'),
              backgroundColor: Colors.white,
              titleTextStyle: GoogleFonts.bebasNeue(
                  color: color.AppColor.homepageTitle,
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            ),
            // backgrond color of the UI
            backgroundColor: color.AppColor.homepageBackground,
            body: Container(
              // use paddding to move the containter down
              padding: const EdgeInsets.only(
                  top: 15, bottom: 35, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Lesson Module App
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Progress Bar
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 130,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              color.AppColor.gradientFirst,
                              color.AppColor.gradientSecond
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.centerRight),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(80)),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(4, 10),
                              blurRadius: 20,
                              color: color.AppColor.gradientSecond
                                  .withOpacity(0.2))
                        ]),
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reminder",
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: color.AppColor.homepagesecondTitle),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Remember to log your expenses and income per day or week",
                            style: GoogleFonts.roboto(
                                fontSize: 20, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  // UI for the three types of Modules
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Row(
                      children: [
                        Text(
                          "Lessons Libaray",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  // UI for the lessons
                  Column(
                    children: [
                      InkWell(
                        child: Container(
                          width: 385,
                          height: 120,
                          margin: EdgeInsets.only(left: 5, top: 10),
                          // show an image for each module
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/income.png")),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(5, 5),
                                    color: Colors.white),
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(-5, -5),
                                    color: Color.fromARGB(255, 246, 243, 243)),
                              ]),

                          child: Center(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                moduleItems[0]["courseName"],
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: color.AppColor.homepagesecondTitle),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoalPage(
                                      moduleItems: moduleItems, index: 0)));
                        },
                      ),
                      InkWell(
                        child: Container(
                          width: 385,
                          height: 120,
                          margin: EdgeInsets.only(left: 5, bottom: 10, top: 10),
                          padding: EdgeInsets.only(bottom: 5),
                          // show an image for each module
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/expenses.png")),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(5, 5),
                                    color: Colors.white),
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(-5, -5),
                                    color: Color.fromARGB(255, 246, 243, 243)),
                              ]),
                          child: Center(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                moduleItems[1]["courseName"],
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: color.AppColor.homepagesecondTitle),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoalPage(
                                      moduleItems: moduleItems, index: 1)));
                        },
                      ),
                      InkWell(
                        child: Container(
                          width: 385,
                          height: 120,
                          margin: EdgeInsets.only(left: 5, bottom: 10, top: 10),
                          padding: EdgeInsets.only(bottom: 5),
                          // show an image for each module
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/savings.png")),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(5, 5),
                                    color: Colors.white),
                                BoxShadow(
                                    blurRadius: 3,
                                    offset: Offset(-5, -5),
                                    color: Color.fromARGB(255, 246, 243, 243)),
                              ]),
                          child: Center(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                moduleItems[2]["courseName"],
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: color.AppColor.homepagesecondTitle),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoalPage(
                                      moduleItems: moduleItems, index: 2)));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
    // return scaffold
  }
}
