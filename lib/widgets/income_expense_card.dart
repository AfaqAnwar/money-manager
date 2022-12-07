import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager/utils/constants.dart';

// Defines the Income & Expense UI Widget
class ExpenseData {
  final String label;
  final String amount;
  final IconData icon;
  final double fontSize;

  const ExpenseData(this.label, this.amount, this.icon, this.fontSize);
}

class IncomeExpenseCard extends StatelessWidget {
  final ExpenseData expenseData;

  const IncomeExpenseCard({Key? key, required this.expenseData})
      : super(key: key);

  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: const EdgeInsets.all(defaultSpacing),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                offset: Offset.zero,
                spreadRadius: 3,
                blurRadius: 12)
          ],
          color: expenseData.label == "Income" ? primaryDark : accent,
          borderRadius: const BorderRadius.all(Radius.circular(defaultRadius))),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expenseData.label,
                style: GoogleFonts.roboto(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(top: defaultSpacing / 3),
                child: Text(
                  expenseData.amount,
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: expenseData.fontSize),
                ),
              )
            ],
          ),
        ),
        Icon(
          expenseData.icon,
          color: Colors.white,
        )
      ]),
    );
  }
}
