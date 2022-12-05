import 'package:flutter/material.dart';

// Main Page
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => CalculatorPageState();
}

class CalculatorPageState extends State<CalculatorPage> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  int result = 0, //INITILIZE VALUES FROM FIREBASE i think?
      num1 = 0,
      num2 = 0,
      num3 = 0,
      anotherResult = 0,
      thirdResult = 0,
      sussy = 0,
      kabob = 0,
      dog = 0,
      goob = 0,
      eep = 0,
      yaygerbomb = 0;

  add() {
    setState(() {
      num1 = int.parse(controller1.text);
      num2 = int.parse(controller2.text);
      num3 = int.parse(controller3.text);

      sussy = num1; //how much they start out with per week

      result = num2; //how much they spend a week

      goob = num3; //how much they wish to save a week

      anotherResult = num1 * 4; //how much they make a month

      thirdResult = num2 * 4; //how much they spend a month

      eep = num3 * 4; //how much they wish to save a month

      kabob = num1 * 12; // how much they make a year

      dog = num2 * 12; // how much they spend a year

      yaygerbomb = num3 * 12; //how much they wish to spend a year
    });
  }

  // Initially checks for survey completion to ensure proper data is present.
  @override
  void initState() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculation"),
        backgroundColor: Color.fromARGB(255, 105, 240, 105),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "MONTHLY SUMMARY:                            "
              "You make $anotherResult dollars per month                               "
              "You spend $thirdResult dollars per month                                "
              "You want to save $eep dollars per month                             "
              "WEEKLY SUMMARY:                                "
              "You start out with $sussy dollars per week                                 "
              "You spend $result dollars per week                           "
              "You want to save $goob dollars per week                             "
              "YEARLY SUMMARY:                                               "
              "You make $kabob dollars per year                                  "
              "You spend $dog dollars per year                                            "
              "You want to save $yaygerbomb dollars per year",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ), //TEXT FIELD 111111111111111111
            TextField(
              controller: controller1,
              decoration: InputDecoration(
                labelText: "Enter How much you make a week",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(
              height: 20,
            ), //TEXT FIELD 2222222222222
            TextField(
              controller: controller2,
              decoration: InputDecoration(
                labelText: "Enter How much you spend a week",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(
              height: 20,
            ), //TEXT FIELD 2222222222222
            TextField(
              controller: controller3,
              decoration: InputDecoration(
                labelText: "Enter How much you want to save per week",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ), //TEST FIELD 33333333333
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    add();
                    controller1
                        .clear(); //if we want to get rid of what we just typed
                    controller2.clear();
                    controller3.clear();
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.greenAccent),
                  child: Text("Calculate"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
