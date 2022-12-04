import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager/data/transactionObject.dart';

import '../utils/constants.dart';

// Defines a TransactionItemMini UI Element Used In Connections Alert.
class TransactionItemMini extends StatelessWidget {
  final TransactionObject transaction;

  const TransactionItemMini({Key? key, required this.transaction})
      : super(key: key);

  Color getBgColor(TransactionObject type) {
    switch (type.itemCategory) {
      case ItemCategory.income:
        return CupertinoColors.activeGreen;
      case ItemCategory.expense:
        return CupertinoColors.systemRed;
      case ItemCategory.finance:
        return CupertinoColors.systemGreen;
      case ItemCategory.personal:
        return CupertinoColors.activeBlue;
      case ItemCategory.food:
        return CupertinoColors.activeOrange;
      case ItemCategory.clothes:
        return CupertinoColors.systemIndigo;
      case ItemCategory.health:
        return CupertinoColors.systemPink;
      case ItemCategory.electronics:
        return CupertinoColors.systemTeal;
      case ItemCategory.fun:
        return CupertinoColors.systemYellow;
      case ItemCategory.other:
        return CupertinoColors.lightBackgroundGray;

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
        return CupertinoIcons.money_dollar;
      case ItemCategory.expense:
        return Icons.fireplace_rounded;
      case ItemCategory.finance:
        return CupertinoIcons.creditcard;
      case ItemCategory.personal:
        return CupertinoIcons.person_circle;
      case ItemCategory.food:
        return Icons.restaurant_menu_rounded;
      case ItemCategory.clothes:
        return Icons.store_rounded;
      case ItemCategory.health:
        return Icons.health_and_safety;
      case ItemCategory.electronics:
        return Icons.laptop;
      case ItemCategory.fun:
        return CupertinoIcons.smiley_fill;
      case ItemCategory.other:
        return CupertinoIcons.creditcard;

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
                  blurRadius: 4,
                  color: Colors.black12,
                  offset: Offset.zero,
                  spreadRadius: 2)
            ],
            borderRadius: BorderRadius.all(Radius.circular(defaultRadius))),
        child: SizedBox(
          width: 290,
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
              style: GoogleFonts.roboto(
                  color: fontHeading,
                  fontSize: fontSizeTitle,
                  fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              transaction.itemDescription,
              style: GoogleFonts.roboto(fontSize: fontSizeBody),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${getSign(transaction.transactionType)}\$${transaction.amount}",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      color: getColor(transaction.transactionType),
                      fontSize: fontSizeBody),
                ),
                const SizedBox(height: 5),
                Text(
                  transaction.date,
                  style: GoogleFonts.roboto(
                      color: fontSubHeading, fontSize: fontSizeBody),
                )
              ],
            ),
          ),
        ));
  }
}
