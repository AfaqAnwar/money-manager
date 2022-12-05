// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager/utils/colors.dart' as colors;
import 'package:moneymanager/pages/helpers/lesson_page.dart';
import 'package:moneymanager/pages/tabs/module_page_tab.dart';

class GoalPage extends StatefulWidget {
  // index of the module they selected
  final index;
  final List moduleItems;

  // when the user clicks on a module you want to pass the module they clicked on so we need to pass the index
  const GoalPage({Key? key, required this.moduleItems, required this.index})
      : super(key: key);
  //const GoalPage({Key? key}) : super(key: key);

  @override
  State<GoalPage> createState() => GoalPageState();
}

class GoalPageState extends State<GoalPage> {
  String goalDescription = "";

// In the Module Page we want to run the UI components and the method to get the data from the Firebase database on the ui
  @override
  void initState() {
    super.initState();
  }

// UI Section
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
        )),
// UI for the top box containing lesson title
        child: Column(
          children: [
            // First container: Title, time
            Container(
              padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: 250,
              // back button ui
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _navigateToPreviousScreen();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _navigateToNextScreen();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    widget.moduleItems[widget.index]['courseName'],
                    style:
                        GoogleFonts.roboto(fontSize: 22, color: Colors.white),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    "Lesson # 1",
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                colors.AppColor.gradientFirst,
                                colors.AppColor.gradientSecond
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            )),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.timer, size: 13, color: Colors.white),
                              Text(
                                "5 mins",
                                style: GoogleFonts.roboto(
                                    fontSize: 13, color: Colors.white),
                              )
                            ]),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Second container: having the lesson desription
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 45, left: 15)),
                        Expanded(
                          child: Flex(direction: Axis.horizontal, children: [
                            Flexible(
                              child: RichText(
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 50,
                                text: TextSpan(
                                  text: widget.moduleItems[widget.index]
                                          ['lesson1']['lessonText']
                                      .toString(),
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w200,
                                      height: 2),
                                ),
                              ),
                            ),
                          ]),
                        ),
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

  _navigateToNextScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LessonPage(
              index: widget.index,
              moduleItems: widget.moduleItems,
            )));
  }

  _navigateToPreviousScreen() {
    Navigator.of(context)
        .pop(MaterialPageRoute(builder: (context) => ModulePage()));
  }
}
