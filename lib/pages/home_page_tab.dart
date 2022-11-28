import 'package:flutter/material.dart';
import 'package:moneymanager/data/transaction.dart';
import 'package:moneymanager/data/user.dart';
import 'package:moneymanager/utils/constants.dart';
import 'package:moneymanager/widget/income_expense_card.dart';
import 'package:moneymanager/widget/transaction_item.dart';

class HomePageTab extends StatefulWidget {
  const HomePageTab({super.key});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

// Home Page Tab that displays user information
class _HomePageTabState extends State<HomePageTab> {
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
                onTap: () {},
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
              transaction: Transaction(
                  ItemCategory.expense,
                  "Shoes",
                  "Nike",
                  "\$40.00",
                  "Nov, 27",
                  "assets/icons/money.png",
                  TransactionType.outflow))
        ]),
      ),
    );
  }
}
