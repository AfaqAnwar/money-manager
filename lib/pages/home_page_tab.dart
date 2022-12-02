import 'dart:convert';
import 'package:date_format/date_format.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager/data/transactionObject.dart';
import 'package:moneymanager/data/user.dart';
import 'package:moneymanager/utils/constants.dart';
import 'package:moneymanager/widget/income_expense_card.dart';
import 'package:moneymanager/widget/transaction_item.dart';
import 'package:xen_popup_card/xen_card.dart';
import 'package:simple_form_builder/formbuilder.dart';
import 'package:moneymanager/data/transaction_input.dart';

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

// Home Page Tab that displays user information
class _HomePageTabState extends State<HomePageTab> {
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
  }

  XenCardGutter gutter = const XenCardGutter(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: CustomButton(text: "Add Transaction"),
    ),
  );

  XenCardAppBar appBar = const XenCardAppBar(
    shadow: BoxShadow(color: Colors.transparent),
    child: Text(
      "Add A Transaction",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
      textAlign: TextAlign.center,
    ), // To remove shadow from appbar
  );

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
                      appBar: appBar,
                      body: ListView(
                        children: [
                          FormBuilder(
                            initialData: inputFormData,
                            index: 0,
                            showIndex: false,
                            submitButtonDecoration: const BoxDecoration(
                                color: Color(0xff6200ee),
                                shape: BoxShape.rectangle),
                            submitButtonText: "Add Transaction",
                            submitTextDecoration: const TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                            widgetCrossAxisAlignment: CrossAxisAlignment.center,
                            onSubmit: (value) async {
                              var json = jsonEncode(value.toJson());
                              var decoded = jsonDecode(json);
                              var incomeOrExpense =
                                  decoded["data"][0]["questions"][0]["answer"];

                              var tempDate = decoded["data"][0]["questions"][1]
                                      ["answer"]
                                  .split(" ")[0]
                                  .split("-");

                              var finalDate = formatDate(
                                  DateTime(
                                      int.parse(tempDate[0]),
                                      int.parse(tempDate[1]),
                                      int.parse(tempDate[2])),
                                  [M, ' ', d, ' ', yyyy]).toString();

                              var localDate =
                                  // ignore: prefer_interpolation_to_compose_strings
                                  finalDate.split(" ")[0] +
                                      " " +
                                      finalDate.split(" ")[1];

                              var amount =
                                  decoded["data"][0]["questions"][2]["answer"];

                              var name =
                                  decoded["data"][0]["questions"][3]["answer"];

                              var company =
                                  decoded["data"][0]["questions"][4]["answer"];

                              var category =
                                  decoded["data"][0]["questions"][5]["answer"];

                              final inputIsValid =
                                  RegExp(r'^[0-9]+$').hasMatch(amount);

                              if (inputIsValid == false) {
                                return showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text('Whoops'),
                                          content: const Text(
                                              'You have to enter only numbers for the transaction amount'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("Okay"),
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
                                        finalDate.toString(),
                                        incomeOrExpense);

                                DocumentSnapshot data = await FirebaseFirestore
                                    .instance
                                    .collection('users')
                                    .doc(CurrentUser.firebaseUser?.uid)
                                    .get();

                                DocumentReference ref = FirebaseFirestore
                                    .instance
                                    .collection('users')
                                    .doc(
                                        FirebaseAuth.instance.currentUser!.uid);

                                TransactionObject
                                    transactionToBeAddedToLocalList =
                                    TransactionObject(
                                        getCategory(category),
                                        name,
                                        company,
                                        amount,
                                        localDate,
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
                                  Navigator.pop(context);
                                  setState(() {
                                    CurrentUser.updateUserIncomeAndExpense();
                                    CurrentUser.updateTotalBalance();
                                  });
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
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: fontSizeHeading, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: defaultSpacing / 2,
              ),
              Text(
                "Total Balance",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: fontSubHeading),
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
                    Icons.arrow_upward_rounded),
              )),
              const SizedBox(
                width: defaultSpacing,
              ),
              Expanded(
                child: IncomeExpenseCard(
                    expenseData: ExpenseData(
                        "Expense",
                        "-\$${CurrentUser.getUserLifetimeExpense}",
                        Icons.arrow_downward_rounded)),
              )
            ],
          ),
          const SizedBox(
            height: defaultSpacing * 2,
          ),
          Text(
            "Recent Transactions",
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: defaultSpacing,
          ),
          const Text(
            "Today",
            style: TextStyle(color: fontSubHeading),
          ),
          const SizedBox(
            height: defaultSpacing,
          ),
          Column(children: getWidgets()),
        ]),
      ),
    );
  }

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

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.text, this.color})
      : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xff6200ee),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Center(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      ),
    );
  }
}
