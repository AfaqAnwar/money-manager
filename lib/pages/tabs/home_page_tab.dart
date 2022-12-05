import 'dart:convert';
import 'package:date_format/date_format.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager/data/transactionObject.dart';
import 'package:moneymanager/data/user.dart';
import 'package:moneymanager/utils/colors.dart';
import 'package:moneymanager/utils/constants.dart';
import 'package:moneymanager/widgets/income_expense_card.dart';
import 'package:moneymanager/widgets/transaction_item.dart';
import 'package:moneymanager/widgets/xen_card.dart';
import 'package:xen_popup_card/xen_card.dart';
import 'package:simple_form_builder/formbuilder.dart';
import 'package:moneymanager/data/transaction_input.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

// Home Page Tab that displays user information
class _HomePageTabState extends State<HomePageTab> {
  late String selectedDate;

  List<TransactionObject> transactionList = [];

  transactionBuilder() {
    for (int i = 0; i < CurrentUser.getTransactionObjects.length; i++) {
      var map = Map<String, dynamic>.from(CurrentUser.getTransactions[i]);
      transactionList.add(TransactionObject.decoded(map));
    }
    CurrentUser.setTransctionObjectList = transactionList;
  }

  @override
  void initState() {
    transactionBuilder();
    CurrentUser.updateUserIncomeAndExpense();
    CurrentUser.updateTotalBalance();
    CurrentUser.parseTransactionsMonthly();

    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    selectedDate = buildDate(date);
  }

  String buildDate(DateTime date) {
    var splitDate =
        date.toString().replaceAll("00:00:00.000", "").trim().split('-');

    String finalDateString = formatDate(
        DateTime(int.parse(splitDate[0]), int.parse(splitDate[1]),
            int.parse(splitDate[2])),
        [M, ' ', d, ' ', yyyy]).toString();

    return finalDateString;
  }

  ItemCategory getCategory(String option) {
    switch (option) {
      case "Income":
        return ItemCategory.income;
      case "Expense":
        return ItemCategory.expense;
      case "Finance":
        return ItemCategory.finance;
      case "Personal":
        return ItemCategory.personal;
      case "Food":
        return ItemCategory.food;
      case "Clothes":
        return ItemCategory.clothes;
      case "Health":
        return ItemCategory.health;
      case "Electronics":
        return ItemCategory.electronics;
      case "Fun":
        return ItemCategory.fun;
      case "Other":
        return ItemCategory.other;

      default:
        return ItemCategory.other;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defaultSpacing),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: defaultSpacing * 4,
          ),
          ListTile(
              title: Text("Hey ${CurrentUser.firstName}!"),
              leading: ClipRRect(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(defaultRadius)),
                  child: Image.asset("assets/icons/user-1.png")),
              trailing: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (builder) => XenPopupCard(
                      appBar: getAppBar("Add A Transaction"),
                      body: ListView(
                        children: [
                          SfDateRangePicker(
                            yearCellStyle: DateRangePickerYearCellStyle(
                                todayTextStyle:
                                    TextStyle(color: AppColor.customDarkGreen)),
                            monthCellStyle: DateRangePickerMonthCellStyle(
                                todayTextStyle:
                                    TextStyle(color: AppColor.customDarkGreen),
                                todayCellDecoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: AppColor.customLightGreen,
                                        width: 2),
                                    shape: BoxShape.circle)),
                            initialSelectedDate: DateTime.now(),
                            backgroundColor: Colors.white,
                            todayHighlightColor: AppColor.customLightGreen,
                            selectionTextStyle:
                                const TextStyle(color: Colors.white),
                            selectionColor: AppColor.customDarkGreen,
                            view: DateRangePickerView.month,
                            selectionMode: DateRangePickerSelectionMode.single,
                            onSelectionChanged:
                                (dateRangePickerSelectionChangedArgs) {
                              var selectedDateOfCalendar =
                                  dateRangePickerSelectionChangedArgs.value;

                              selectedDate = buildDate(selectedDateOfCalendar);
                            },
                          ),
                          FormBuilder(
                            initialData: inputFormData,
                            index: 0,
                            showIndex: false,
                            submitButtonDecoration: BoxDecoration(
                                color: AppColor.customDarkGreen,
                                shape: BoxShape.rectangle),
                            submitButtonText: "Add Transaction",
                            submitTextDecoration: GoogleFonts.roboto(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            widgetCrossAxisAlignment: CrossAxisAlignment.center,
                            onSubmit: (value) async {
                              if (value != null) {
                                var json = jsonEncode(value.toJson());
                                var decoded = jsonDecode(json);
                                var incomeOrExpense = decoded["data"][0]
                                    ["questions"][0]["answer"];

                                var year = selectedDate.split(" ")[2];

                                var amount = decoded["data"][0]["questions"][1]
                                    ["answer"];

                                var name = decoded["data"][0]["questions"][2]
                                    ["answer"];

                                var company = decoded["data"][0]["questions"][3]
                                    ["answer"];

                                var category = decoded["data"][0]["questions"]
                                    [4]["answer"];

                                final inputIsValid =
                                    RegExp(r'^[0-9]+$').hasMatch(amount);

                                if (inputIsValid == false) {
                                  return showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            titleTextStyle: GoogleFonts.roboto(
                                                color:
                                                    AppColor.customLightGreen,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 24),
                                            contentTextStyle:
                                                GoogleFonts.roboto(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                            title: const Text('Whoops'),
                                            content: const Text(
                                                'You have to enter only numbers for the transaction amount'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text("Okay",
                                                    style: GoogleFonts.roboto(
                                                        color: AppColor
                                                            .customDarkGreen,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              )
                                            ],
                                          ));
                                } else {
                                  if (incomeOrExpense == "Income") {
                                    incomeOrExpense = TransactionType.inflow;
                                  } else {
                                    incomeOrExpense = TransactionType.outflow;
                                  }

                                  TransactionObject transaction =
                                      TransactionObject(
                                          getCategory(category),
                                          name,
                                          company,
                                          amount,
                                          selectedDate,
                                          year,
                                          incomeOrExpense);

                                  DocumentSnapshot data =
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(CurrentUser.firebaseUser?.uid)
                                          .get();

                                  DocumentReference ref = FirebaseFirestore
                                      .instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid);

                                  TransactionObject
                                      transactionToBeAddedToLocalList =
                                      TransactionObject(
                                          getCategory(category),
                                          name,
                                          company,
                                          amount,
                                          "${selectedDate.split(" ")[0]} ${selectedDate.split(" ")[1]}",
                                          year,
                                          incomeOrExpense);

                                  var transactions;

                                  try {
                                    transactions = data.get("transactions");
                                  } catch (e) {
                                    List<dynamic> transactions = [];
                                  }
                                  transactions.insert(0, transaction.toMap());
                                  await ref
                                      .update({"transactions": transactions});

                                  CurrentUser.setTransactions = transactions;
                                  transactionList.insert(
                                      0, transactionToBeAddedToLocalList);

                                  if (mounted) {
                                    Navigator.of(builder).pop();
                                    setState(() {
                                      CurrentUser.updateUserIncomeAndExpense();
                                      CurrentUser.updateTotalBalance();
                                      CurrentUser.parseTransactionsMonthly();
                                    });
                                  }
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Image.asset("assets/icons/plus.png"),
              )),
          const SizedBox(
            height: defaultSpacing,
          ),
          Center(
            child: Column(children: [
              Text(
                "\$${CurrentUser.getTotalBalance}",
                style: GoogleFonts.roboto(
                    fontSize: fontSizeHeading * 1.5,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: defaultSpacing / 2,
              ),
              Text(
                "Total Balance",
                style: GoogleFonts.roboto(color: fontSubHeading),
              )
            ]),
          ),
          const SizedBox(
            height: defaultSpacing * 2,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: IncomeExpenseCard(
                expenseData: ExpenseData(
                    "Income",
                    "\$${CurrentUser.getUserLifetimeIncome}",
                    CupertinoIcons.arrow_up),
              )),
              const SizedBox(
                width: defaultSpacing,
              ),
              Expanded(
                child: IncomeExpenseCard(
                    expenseData: ExpenseData(
                        "Expense",
                        "-\$${CurrentUser.getUserLifetimeExpense}",
                        CupertinoIcons.arrow_down)),
              )
            ],
          ),
          const SizedBox(
            height: defaultSpacing * 2,
          ),
          Text(
            "Recent Transactions",
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700, fontSize: fontSizeTitle),
          ),
          const SizedBox(
            height: defaultSpacing / 3,
          ),
          Text(
            "Today",
            style: GoogleFonts.roboto(color: fontSubHeading),
          ),
          const SizedBox(
            height: defaultSpacing,
          ),
          Column(children: getWidgets()),
        ]),
      ),
    );
  }

// Builds each transaction widget.
  List<Widget> getWidgets() {
    List<Widget> list = [];
    for (int i = 0; i < transactionList.length; i++) {
      list.add(Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) async {
            DocumentSnapshot data = await FirebaseFirestore.instance
                .collection('users')
                .doc(CurrentUser.firebaseUser?.uid)
                .get();

            DocumentReference ref = FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid);
            setState(() {
              transactionList.removeAt(i);

              var transactionsFromDB = data.get("transactions");
              transactionsFromDB.removeAt(i);

              ref.update({"transactions": transactionsFromDB});
              CurrentUser.setTransactions = transactionsFromDB;

              CurrentUser.updateUserIncomeAndExpense();
              CurrentUser.updateTotalBalance();
              CurrentUser.parseTransactionsMonthly();
            });
          },
          confirmDismiss: (DismissDirection direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Delete Confirmation"),
                  content: const Text(
                      "Are you sure you want to delete this transaction?"),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text("Delete")),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Cancel"),
                    ),
                  ],
                );
              },
            );
          },
          child: TransactionItem(transaction: transactionList[i])));
    }
    return list;
  }
}
