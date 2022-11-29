import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moneymanager/data/transaction.dart';
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
                            onSubmit: (value) {
                              var json = jsonEncode(value.toJson());
                              var decoded = jsonDecode(json);
                              var incomeOrExpense =
                                  decoded["data"][0]["questions"][0]["answer"];

                              var amount =
                                  decoded["data"][0]["questions"][1]["answer"];

                              var category =
                                  decoded["data"][0]["questions"][2]["answer"];

                              final inputIsValid =
                                  RegExp(r'^[0-9]+$').hasMatch(amount);

                              if (inputIsValid == false) {
                                showDialog(
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
                                // Submit Data
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
                "\$4,569.00",
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
            children: const [
              Expanded(
                  child: IncomeExpenseCard(
                expenseData: ExpenseData(
                    "Income", "\$2,000.00", Icons.arrow_upward_rounded),
              )),
              SizedBox(
                width: defaultSpacing,
              ),
              Expanded(
                child: IncomeExpenseCard(
                    expenseData: ExpenseData("Expense", "-\$9,000.00",
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
          // ..userdata.transactions.map(transction) => TransactionItem(transction:transaction)
          const TransactionItem(
            transaction: Transaction(ItemCategory.expense, "Shoes", "Nike",
                "\$40.00", "Nov, 27", TransactionType.outflow),
          ),
          const TransactionItem(
            transaction: Transaction(ItemCategory.income, "Direct Deposit",
                "NYIT", "\$200.00", "Nov, 27", TransactionType.inflow),
          ),
          const TransactionItem(
            transaction: Transaction(ItemCategory.food, "Burrito Bowl",
                "Chipotle", "\$15.00", "Nov, 27", TransactionType.outflow),
          )
        ]),
      ),
    );
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
