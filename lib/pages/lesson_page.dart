// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:moneymanager/colors.dart' as colors;
import 'package:moneymanager/module_list_items.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:moneymanager/pages/module_page.dart';
import 'package:moneymanager/pages/quiz_page.dart';


class LessonPage extends StatefulWidget{
  
  
  //const LessonPage({super.key, required this.module});
  const LessonPage({Key? key}) : super(key: key);

  //final ModulesListItems module;

  @override
  State<LessonPage> createState() => LessonPageState();
}

class LessonPageState extends State<LessonPage> {


   List<ModulesListItems> courses = [];

// In the Module Page we want to run the UI components and the method to get the data from the Firebase database on the ui
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(

        // background color
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors.AppColor.gradientFirst,
              colors.AppColor.gradientSecond

            ],
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
            
            )
        ),
// UI for the top box containing lesson title
        child: Column(
          children: [
            // First container: Title, time
            Container(
              padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              height: 250,
              // back button ui
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_back_ios, size: 25,
                      color: Colors.white),
                      Row(
                        children: [
                          Icon(Icons.arrow_forward_ios, size: 25,
                          color: Colors.white),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text(
                    "Lesson # 1",
                    style: TextStyle(
                    fontSize: 22,
                    color: Colors.white
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: 
                          [
                            colors.AppColor.gradientFirst,
                            colors.AppColor.gradientSecond
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer, 
                            size: 20,
                            color: Colors.white),
                            SizedBox(width: 5,),
                            Text(
                              "15 mins",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white 
                              ),
                            )

                          ]
                        ),
                      
                      )
                    ],
                  )

                ],
              ),
            ),
            // Second container: having the lesson desription
            Expanded(child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(75)
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 100, left: 30)),
                      Text(
                        "About the lesson",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w200
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
        ),
      ],
    ),
    ),
    );
  }
}