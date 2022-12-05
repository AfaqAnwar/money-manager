import 'package:flutter/material.dart';
import 'package:moneymanager/pages/tabs/home_page_tab.dart';
import 'package:moneymanager/pages/tabs/module_page_tab.dart';
import 'package:moneymanager/utils/colors.dart' as colors;

import '../home_page_host.dart';

class ResultsPage extends StatefulWidget {
  // Final variable to store the score the user recieved from the quiz
  final result;

  const ResultsPage({Key? key, required this.result}) : super(key: key);

  @override
  State<ResultsPage> createState() => ResultsPageState();
}

class ResultsPageState extends State<ResultsPage> {
// In the Module Page we want to run the UI components and the method to get the data from the Firebase database on the ui
  @override
  void initState() {
    super.initState();
  }

// UI for the result page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // add the gradient background color
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors.AppColor.gradientFirst,
              colors.AppColor.gradientSecond
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 300, right: 20),
              child: Text(
                "Congrats your score is: ${widget.result.toString()} / 3",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                softWrap: true,
                maxLines: 5,
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 100)),
            Container(child: buildElevatedButton(context)),
          ],
        ),
      ),
    );
  }
}

// UI for button to take back to module page
ElevatedButton buildElevatedButton(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
    onPressed: () {
      Navigator.of(context)
          .pop(MaterialPageRoute(builder: (context) => HomePage()));
    },
    child: const Text(
      "Done",
      style: TextStyle(color: Colors.black),
    ),
  );
}
