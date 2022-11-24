// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/colors.dart' as color;
import 'package:moneymanager/module_list_items.dart';


class ModulePage extends StatefulWidget {
  const ModulePage({Key? key}) : super(key: key);

  @override
  State<ModulePage> createState() => ModulePageState();
}

class ModulePageState extends State<ModulePage> {

  List<ModulesListItems> courses = [];

// In the Module Page we want to run the UI components and the method to get the data from the Firebase database on the ui
  @override
  void initState(){
    super.initState();
    initData();
  }

    // Method to retrieve module data from the Firebase Reael time Database
  Future initData() async {

    // get a reference of our firebase database 
    //DatabaseReference childRef1 = FirebaseDatabase.instance.ref('Modules/0');
    //DatabaseReference childRef2 = FirebaseDatabase.instance.ref('Modules/1');
    //DatabaseReference childRef3 = FirebaseDatabase.instance.ref('Modules/2');

    // get the database once
    //DatabaseEvent event = await childRef1.once();



    for(int i = 0; i < 3; i++){
      
      // ignore: prefer_interpolation_to_compose_strings
      var childPath = "Modules/" + i.toString();
      //print(childPath);

      DatabaseReference ref = FirebaseDatabase.instance.ref(childPath);
      DatabaseEvent event = await ref.once();
      var json = event.snapshot.value as Map<dynamic,dynamic>;

      Map<String, String> lessonDict = {};

      var courseName = json['courseName'];

      var lesson1Name = json['lesson1']['lessonName'];
      var lesson1Text = json['lesson1']['lessonText'];
      var lesson2Name = json['lesson2']['lessonName'];
      var lesson2Text = json['lesson2']['lessonText'];

      lessonDict[lesson1Name] = lesson1Text;
      lessonDict[lesson2Name] = lesson2Text;
      //print(lessonDict);

      var q1 = json['question1'];
      var q2 = json['question2'];
      var q3 = json['question3'];

      //print(q1);

      var quizDict = {q1, q2, q3};
      //print(quizDict);

      ModulesListItems m = ModulesListItems(courseName, lessonDict, quizDict);
      courses.add(m);

      //print(m.getModuleTitle());

    }

    for(int i = 0; i < courses.length; i++){
      print(courses[i].getModuleTitle());

    }
    
  
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
          fontWeight: FontWeight.w800
        ),
      ),
      // backgrond color of the UI
      backgroundColor: color.AppColor.homepageBackground,
      body: Container(
          // use paddding to move the containter down
          padding: const EdgeInsets.only(top: 25, bottom: 35, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                // Lesson Module App
            ],
          ),
            SizedBox(height: 20,),
            // Progress Bar
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150, 
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.AppColor.gradientFirst,
                    color.AppColor.gradientSecond
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.centerRight
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(80)
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(4,10),
                    blurRadius: 20,
                    color: color.AppColor.gradientSecond.withOpacity(0.2)
                  )
                ]
                ),
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 25), 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Reminder",
                      style: TextStyle(
                        fontSize: 16,
                        color: color.AppColor.homepagesecondTitle
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "Remember to log your expenses and income per day or week",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white
                      ),
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
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600
                  ),
                )
              ],
            ),
          ),
            // UI for the lessons 
            Expanded(child: ListView.builder(
              // How many items will we have in the UI row
              itemCount: 3,
              itemBuilder: (_, i){
                return Row(
                  children: [
                    Container(
                     width: 385,
                      height: 130,
                      margin: EdgeInsets.only(left: 5, bottom: 15, top:20),
                      padding: EdgeInsets.only(bottom: 5),
                     // show an image for each module 
                      decoration: BoxDecoration(
                        color: Colors.white, 
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/income.png"
                          )
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            offset: Offset(5, 5),
                            color: Colors.white
                          ),
                          BoxShadow(
                            blurRadius: 3,
                            offset: Offset(-5, -5),
                            color: Color.fromARGB(255, 246, 243, 243)
                          ),
                        ]
                      ),
                      child: Center(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                        child: Text(
                          courses[i].getModuleTitle(),
                          style: TextStyle(
                            fontSize: 20,
                            color: color.AppColor.homepagesecondTitle
                          )
                        ),
                        )
                      )
                    )
                  ],
                );
              })) 
          
          ],
        ),
      )

    ); // return scaffold

  }

}