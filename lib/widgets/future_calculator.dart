import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager/utils/colors.dart';
import 'package:moneymanager/widgets/xen_card.dart';
import 'package:xen_popup_card/xen_card.dart';

var weeklyEstimateController = TextEditingController();
var weeklySpendingController = TextEditingController();
var plannedSavingController = TextEditingController();

double weeklyIncome = 0;
double weeklySpending = 0;
double weeklyPlannedSavings = 0;

double monthlyIncome = 0;
double monthlySpending = 0;
double monthlySaving = 0;
double yearlyIncome = 0;
double yearlySpending = 0;
double yearlySaving = 0;

void parseControllers() {
  weeklyIncome = double.parse(weeklyEstimateController.text.trim());
  weeklySpending = double.parse(weeklySpendingController.text.trim());
  weeklyPlannedSavings = double.parse(plannedSavingController.text.trim());
  weeklyIncome = double.parse(weeklyIncome.toStringAsFixed(2));
  weeklySpending = double.parse(weeklySpending.toStringAsFixed(2));
  weeklyPlannedSavings = double.parse(weeklyPlannedSavings.toStringAsFixed(2));
}

bool checkAllControllers() {
  return inputIsValid(weeklyEstimateController.text.trim()) &&
      inputIsValid(weeklySpendingController.text.trim()) &&
      inputIsValid(plannedSavingController.text.trim());
}

Widget buildFutureCalculator(BuildContext context) {
  return Column(children: [
    Text(
      'Future Planning',
      style:
          GoogleFonts.bebasNeue(fontSize: 32, color: AppColor.customLightGreen),
    ),
    Expanded(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: weeklyEstimateController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Income Per Week",
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                controller: weeklySpendingController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Spending Per Week",
                                ),
                              ),
                            ))),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                controller: plannedSavingController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Planned Savings Per Week",
                                ),
                              ),
                            ))),
                    const SizedBox(height: 25),
                    MaterialButton(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        color: AppColor.customDarkGreen,
                        onPressed: () {
                          if (checkAllControllers()) {
                            parseControllers();

                            monthlyIncome = weeklyIncome * 4;
                            monthlySpending = weeklySpending * 4;
                            monthlySaving = weeklyPlannedSavings * 4;
                            yearlyIncome = monthlyIncome * 12;
                            yearlySpending = monthlySpending * 12;
                            yearlySaving = monthlySaving * 12;
                            showDialog(
                                context: context,
                                builder: (builder) => XenPopupCard(
                                      appBar:
                                          getAppBar("A Look Into The Future"),
                                      body: Column(children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'You make ',
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customLightGreen,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "\$$weeklyIncome per week.",
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customDarkGreen,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ]),
                                        const SizedBox(height: 15),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'You spend ',
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customLightGreen,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "\$$weeklySpending per week.",
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customDarkGreen,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ]),
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'You Save ',
                                              style: GoogleFonts.bebasNeue(
                                                  fontSize: 26,
                                                  color:
                                                      AppColor.customLightGreen,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "\$$weeklyPlannedSavings per week.",
                                              style: GoogleFonts.bebasNeue(
                                                  fontSize: 26,
                                                  color:
                                                      AppColor.customDarkGreen,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 25),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'You make ',
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customLightGreen,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "\$$monthlyIncome per month.",
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customDarkGreen,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ]),
                                        const SizedBox(height: 15),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'You spend ',
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customLightGreen,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "\$$monthlySpending per month.",
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customDarkGreen,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ]),
                                        const SizedBox(height: 15),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'You Save ',
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customLightGreen,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "\$$monthlySaving per month.",
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customDarkGreen,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ]),
                                        const SizedBox(height: 25),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'You make ',
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customLightGreen,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "\$$yearlyIncome per year.",
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customDarkGreen,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ]),
                                        const SizedBox(height: 15),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'You spend ',
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customLightGreen,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "\$$yearlySpending per year.",
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customDarkGreen,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ]),
                                        const SizedBox(height: 15),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'You Save ',
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customLightGreen,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "\$$yearlySaving per year.",
                                                style: GoogleFonts.bebasNeue(
                                                    fontSize: 26,
                                                    color: AppColor
                                                        .customDarkGreen,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ])
                                      ]),
                                      gutter: getGutter("Okay"),
                                    ));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      titleTextStyle: GoogleFonts.roboto(
                                          color: AppColor.customLightGreen,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 24),
                                      contentTextStyle: GoogleFonts.roboto(
                                          color: Colors.black, fontSize: 16),
                                      title: const Text('Whoops'),
                                      content: const Text(
                                          'Please enter valid inputs for your planned values.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            "Try again",
                                            style: GoogleFonts.roboto(
                                                color: AppColor.customDarkGreen,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ));
                          }
                        },
                        child: Text(
                          "Calculate",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ])),
            )))
  ]);
}

bool inputIsValid(String s) {
  if (s.isEmpty) {
    return false;
  } else if (s.length == 1 && s.contains("0")) {
    return false;
  } else if (s.contains(RegExp(r'^(\d*\.)?\d+$'))) {
    return true;
  } else if (s.contains(".")) {
    if (s.indexOf(".") != 0) {
      if (s.substring(0, s.indexOf(".")).contains(RegExp(r'^(\d*\.)?\d+$'))) {
        return true;
      }
    }
  }
  return false;
}
