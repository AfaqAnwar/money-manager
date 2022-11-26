// ignore_for_file: prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:moneymanager/colors.dart' as colors;
import 'package:moneymanager/module_list_items.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:moneymanager/pages/module_page.dart';


class QuizPage extends StatefulWidget{

  const QuizPage({super.key});
  
  @override
  State<QuizPage> createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {

// Test Data to see if the backend of the system is working
  final dataQuestions = [
  Question(text: "What is Sanzida's middle name",
   options: [
    const Option(text: "Afrin", isCorrect: true),
    const Option(text: "None", isCorrect: false),
    const Option(text: "Binte", isCorrect: false),
   ]),
   Question(text: "When is our second exam?", 
   options: [
    const Option(text: "Nov 31", isCorrect: true),
    const Option(text: "Dec 31", isCorrect: false),
    const Option(text: "July 4", isCorrect: false)
   ])
];

  // PageController for the next question controller
  late PageController _controller;
  // variable to hold what question we are on
  int _questionNumber = 1;

  @override
  void initState(){
    super.initState();
    _controller = PageController(initialPage: 0);

  }

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 20,),
          // ignore: prefer_const_constructors
          Text(
            'Question$_questionNumber/${dataQuestions.length}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12
            ),
            ),
          const Divider(thickness: 1, color: Colors.blueGrey,),
          Expanded(
            child: PageView.builder(
              itemCount: dataQuestions.length,
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) {
                final _question = dataQuestions[index];
                return buildQuestion(_question);
              })),
          ),
          buildElevatedButton(),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }

  Column buildQuestion(Question question){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32,),
        Text(
          question.text,
          style: 
            TextStyle(
              fontSize: 25,
              color: Colors.white
            ),
        ),
        const SizedBox(height: 32,),
        Expanded(
          child: OptionWidget(
            question: question,
            onClickedOption: (option) {
              if(question.isLocked){
                return;
              }
              else{
                setState(() {
                  question.isLocked = true;
                  question.selectedOption = option;
                });

              }
            },
          ),
        )
      ],
    );
  }
  
  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        if(_questionNumber < dataQuestions.length) {
          _controller.nextPage(
            duration: const Duration(milliseconds:  250),
            curve: Curves.easeInExpo,
          );

          setState(() {
            _questionNumber++;
          });
        } else {}
      }, 
      child: Text(
        _questionNumber < dataQuestions.length ? 'Next Page' : 'Finished the test'),
      );
  }
}

class OptionWidget extends StatelessWidget {

    final Question question;
    final ValueChanged<Option> onClickedOption;

    const OptionWidget({
      Key? key,
      required this.question, 
      required this.onClickedOption,
    }): super(key: key);

    @override
    Widget build(BuildContext context) => SingleChildScrollView(
      child:  Column(
        children: question.options.map((option) => buildOption(context, option)).toList(),
        ),
      );

    Widget buildOption(BuildContext context, Option option){
      final color = getColorForOption(option, question);
      return GestureDetector(
        onTap: () => onClickedOption(option),
        child: Container(
          height: 50,
          padding:  const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(19),
            border: Border.all(color: color)
          ),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              option.text,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      )
    );
  }
}

Color getColorForOption(Option option, Question question) {
  final isSelected = option == question.selectedOption;
  if(question.isLocked){
    if(isSelected){
      return option.isCorrect? Colors.green : Colors.red;
    } else if(option.isCorrect){
      return Colors.green;
    }
  }
  return Colors.white;
}
