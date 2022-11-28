import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moneymanager/data/transaction.dart';

import '../utils/constants.dart';

// Defines a TransactionItem UI Element.
class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({Key? key, required this.transaction})
      : super(key: key);

  Color getBgColor(Transaction type) {
    switch (type.itemCategory) {
      case ItemCategory.expense:
        return Colors.redAccent;
      case ItemCategory.food:
        return Colors.blueAccent;
      case ItemCategory.fun:
        return Colors.yellow;
      case ItemCategory.income:
        return Colors.green;
      case ItemCategory.other:
        return Colors.grey;

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

  IconData getIcon(Transaction type) {
    switch (type.itemCategory) {
      case ItemCategory.expense:
        return Icons.credit_card;
      case ItemCategory.food:
        return Icons.food_bank;
      case ItemCategory.fun:
        return Icons.emoji_emotions_rounded;
      case ItemCategory.income:
        return Icons.money_rounded;
      case ItemCategory.other:
        return Icons.question_mark;

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
          transaction.itemCategoryName,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: fontHeading, fontSize: fontSizeTitle),
        ),
        subtitle: Text(transaction.itemName),
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
