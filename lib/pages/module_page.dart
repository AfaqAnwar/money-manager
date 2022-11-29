// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, prefer_typing_uninitialized_variables, unused_field
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneymanager/colors.dart' as color;
import 'package:moneymanager/module_items.dart';
import 'package:moneymanager/pages/lesson_goal_page.dart';
import 'package:moneymanager/pages/lesson_page.dart';

class ModulePage extends StatefulWidget {
  const ModulePage({Key? key}) : super(key: key);

  @override
  State<ModulePage> createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  List moduleItems = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/images/data/lessons.json');
    final data = await json.decode(response);
    setState(() {
      moduleItems = data["Modules"];
    });
    print(moduleItems[1]['lesson1']['lessonText']);
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Widget progressBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            color.AppColor.gradientFirst,
            color.AppColor.gradientSecond
          ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(80)),
          boxShadow: [
            BoxShadow(
                offset: Offset(4, 10),
                blurRadius: 20,
                color: color.AppColor.gradientSecond.withOpacity(0.2))
          ]),
    );
  }

// UI Design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modules'),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            color: color.AppColor.homepageTitle,
            fontSize: 30,
            fontWeight: FontWeight.w800),
      ),
      // backgrond color of the UI
      backgroundColor: color.AppColor.homepageBackground,
      body: Container(
        // use paddding to move the containter down
        padding:
            const EdgeInsets.only(top: 25, bottom: 35, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                // Lesson Module App
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // Progress Bar
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    color.AppColor.gradientFirst,
                    color.AppColor.gradientSecond
                  ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(80)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(4, 10),
                        blurRadius: 20,
                        color: color.AppColor.gradientSecond.withOpacity(0.2))
                  ]),
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reminder",
                      style: TextStyle(
                          fontSize: 16,
                          color: color.AppColor.homepagesecondTitle),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Remember to log your expenses and income per day or week",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            // UI for the three types of Modules
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                children: [
                  Text(
                    "Lessons Libaray",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
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
                    height: 130,
                    margin: EdgeInsets.only(left: 5, bottom: 15, top: 20),
                    padding: EdgeInsets.only(bottom: 5),
                    // show an image for each module
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage("assets/images/income.png")),
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
                          style: TextStyle(
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
                            builder: (context) =>
                                GoalPage(moduleItems: moduleItems, index: 0)));
                  },
                ),
                InkWell(
                  child: Container(
                    width: 385,
                    height: 130,
                    margin: EdgeInsets.only(left: 5, bottom: 15, top: 20),
                    padding: EdgeInsets.only(bottom: 5),
                    // show an image for each module
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage("assets/images/income.png")),
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
                          style: TextStyle(
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
                            builder: (context) =>
                                GoalPage(moduleItems: moduleItems, index: 1)));
                  },
                ),
                InkWell(
                  child: Container(
                    width: 385,
                    height: 130,
                    margin: EdgeInsets.only(left: 5, bottom: 15, top: 20),
                    padding: EdgeInsets.only(bottom: 5),
                    // show an image for each module
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage("assets/images/income.png")),
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
                          style: TextStyle(
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
                            builder: (context) =>
                                GoalPage(moduleItems: moduleItems, index: 2)));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
    // return scaffold
  }
}
