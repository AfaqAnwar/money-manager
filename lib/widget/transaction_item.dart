import 'package:flutter/material.dart';
import 'package:moneymanager/data/transactionObject.dart';

import '../utils/constants.dart';

// Defines a TransactionItem UI Element.
class TransactionItem extends StatelessWidget {
  final TransactionObject transaction;

  const TransactionItem({Key? key, required this.transaction})
      : super(key: key);

  Color getBgColor(TransactionObject type) {
    switch (type.itemCategory) {
      case ItemCategory.income:
        return Colors.green;
      case ItemCategory.expense:
        return Colors.red;
      case ItemCategory.finance:
        return Colors.greenAccent;
      case ItemCategory.personal:
        return Colors.blue;
      case ItemCategory.food:
        return Colors.orangeAccent;
      case ItemCategory.clothes:
        return Colors.cyanAccent;
      case ItemCategory.health:
        return Colors.pinkAccent;
      case ItemCategory.electronics:
        return Colors.limeAccent;
      case ItemCategory.fun:
        return Colors.purple;
      case ItemCategory.other:
        return Colors.tealAccent;

      default:
        return Colors.grey;
    }
  }

  String getSign(TransactionType type) {
    switch (type) {
      case TransactionType.inflow:
        return "+";
      case TransactionType.outflow:
        return "-";
    }
  }

  Color getColor(TransactionType type) {
    if (type == TransactionType.inflow) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  IconData getIcon(TransactionObject type) {
    switch (type.itemCategory) {
      case ItemCategory.income:
        return Icons.money_rounded;
      case ItemCategory.expense:
        return Icons.fireplace_rounded;
      case ItemCategory.finance:
        return Icons.credit_card_rounded;
      case ItemCategory.personal:
        return Icons.person;
      case ItemCategory.food:
        return Icons.restaurant_menu_rounded;
      case ItemCategory.clothes:
        return Icons.storefront_rounded;
      case ItemCategory.health:
        return Icons.local_hospital_rounded;
      case ItemCategory.electronics:
        return Icons.computer_rounded;
      case ItemCategory.fun:
        return Icons.emoji_emotions_rounded;
      case ItemCategory.other:
        return Icons.question_answer_rounded;

      default:
        return Icons.question_mark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: defaultSpacing),
      decoration: const BoxDecoration(
          color: background,
          boxShadow: [
            BoxShadow(
                blurRadius: 12,
                color: Colors.black12,
                offset: Offset.zero,
                spreadRadius: 3)
          ],
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius))),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: getBgColor(transaction),
              borderRadius:
                  const BorderRadius.all(Radius.circular(defaultRadius))),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(getIcon(transaction))),
        ),
        title: Text(
          transaction.itemCompany,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: fontHeading, fontSize: fontSizeTitle),
        ),
        subtitle: Text(transaction.itemDescription),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${getSign(transaction.transactionType)}${transaction.amount}",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: getColor(transaction.transactionType),
                  fontSize: fontSizeBody),
            ),
            Text(
              transaction.date,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: fontSubHeading, fontSize: fontSizeBody),
            )
          ],
        ),
      ),
    );
  }
}
