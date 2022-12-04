// ignore_for_file: prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager/utils/colors.dart' as colors;
import 'package:moneymanager/data/module_items.dart';
import 'package:moneymanager/pages/helpers/lesson_goal_page.dart';

class QuizPage extends StatefulWidget {
  // index of the module they selected
  final index;
  final List moduleItems;

  // when the user clicks on a module you want to pass the module they clicked on so we need to pass the index
  const QuizPage({Key? key, required this.moduleItems, required this.index})
      : super(key: key);

  @override
  State<QuizPage> createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
// Test Data to see if the backend of the system is working
  final dataQuestions = [];

// Load the data and format for the questions in the correct format needed for the UI

  // PageController for the next question controller
  late PageController _controller;
  // variable to hold what question we are on
  int _questionNumber = 1;

  @override
  // ignore: must_call_super
  void initState() {
    _controller = PageController(initialPage: 0);

    dataQuestions.add(Question(
        text: widget.moduleItems[widget.index]["question1"]["question"]
            .toString(),
        options: [
          Option(
              text: widget.moduleItems[widget.index]["question1"]["choices"][0]
                  .toString(),
              isCorrect: false),
          Option(
              text: widget.moduleItems[widget.index]["question1"]["choices"][1]
                  .toString(),
              isCorrect: true)
        ]));

    dataQuestions.add(Question(
        text: widget.moduleItems[widget.index]["question2"]["question"]
            .toString(),
        options: [
          Option(
              text: widget.moduleItems[widget.index]["question2"]["choices"][0]
                  .toString(),
              isCorrect: false),
          Option(
              text: widget.moduleItems[widget.index]["question2"]["choices"][1]
                  .toString(),
              isCorrect: true)
        ]));

    dataQuestions.add(Question(
        text: widget.moduleItems[widget.index]["question2"]["question"]
            .toString(),
        options: [
          Option(
              text: widget.moduleItems[widget.index]["question2"]["choices"][0]
                  .toString(),
              isCorrect: false),
          Option(
              text: widget.moduleItems[widget.index]["question2"]["choices"][1]
                  .toString(),
              isCorrect: true)
        ]));
  }

  // UI for the question page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Question 1/2'),
          backgroundColor: colors.AppColor.homepageTitle,
          titleTextStyle: GoogleFonts.roboto(
              color: colors.AppColor.homepageTitle,
              fontSize: 25,
              fontWeight: FontWeight.w800),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20,
              ),
              // ignore: prefer_const_constructors
              // Question area for all the related questions in the modules
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
              // This is the Next button UI
              buildElevatedButton(),
              const SizedBox(
                height: 300,
              ),
            ],
          ),
        ));
  }

// UI for the Questions
  Column buildQuestion(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20),
        ),
        Text(
          question.text,
          style: GoogleFonts.roboto(
            fontSize: 25,
            color: colors.AppColor.homepageTitle,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Expanded(
          child: OptionWidget(
            question: question,
            onClickedOption: (option) {
              if (question.isLocked) {
                return;
              } else {
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

// Functin to handle the backend for the next button
  MaterialButton buildElevatedButton() {
    return MaterialButton(
      color: colors.AppColor.customDarkGreen,
      // when pressed and it is less than the number of questions go to the next questions
      onPressed: () {
        if (_questionNumber < dataQuestions.length) {
          _controller.nextPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInExpo,
          );
          setState(() {
            _questionNumber++;
          });
        }
        // else if they completed all the questions go to the resulting page
        else {
          // To - Do make a result page
          Navigator.of(context).pop(MaterialPageRoute(
              builder: (context) => GoalPage(
                    moduleItems: [],
                    index: null,
                  )));
        }
      },
      // Change the UI text for the Next button
      child: Text(
        _questionNumber < dataQuestions.length
            ? 'Next Page'
            : 'Finished the test',
        style: GoogleFonts.roboto(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// Class for the option weidget for all the question multiple choices
class OptionWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onClickedOption;

  const OptionWidget({
    Key? key,
    required this.question,
    required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: question.options
              .map((option) => buildOption(context, option))
              .toList(),
        ),
      );

// build the UI for the multiple choices

  Widget buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, question);
    return GestureDetector(
        onTap: () => onClickedOption(option),
        child: Container(
          height: 50,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(19),
              border: Border.all(color: color)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                option.text,
                style: const TextStyle(fontSize: 10),
              )
            ],
          ),
        ));
  }
}

// Color Scheme for the correct and wrong question selected
Color getColorForOption(Option option, Question question) {
  final isSelected = option == question.selectedOption;
  if (question.isLocked) {
    if (isSelected) {
      return option.isCorrect
          ? Color.fromARGB(255, 255, 255, 255)
          : Color.fromARGB(255, 255, 17, 0);
    } else if (option.isCorrect) {
      return Color.fromARGB(255, 255, 255, 255);
    }
  }
  return Colors.white;
}
