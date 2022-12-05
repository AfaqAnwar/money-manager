enum TransactionType { outflow, inflow }

enum ItemCategory {
  income,
  expense,
  finance,
  personal,
  food,
  clothes,
  health,
  electronics,
  fun,
  other
}

// Transaction Object Class
class TransactionObject {
  late ItemCategory itemCategory;
  late String itemDescription;
  late String itemCompany;
  late String amount;
  late String date;
  late TransactionType transactionType;

  TransactionObject(
    this.itemCategory,
    this.itemDescription,
    this.itemCompany,
    this.amount,
    this.date,
    this.transactionType,
  );

  get getItemCategory {
    return itemCategory;
  }

  get getItemDescription {
    return itemDescription;
  }

  get getItemCompany {
    return itemCompany;
  }

  get getItemAmount {
    return amount;
  }

  get getDate {
    return date;
  }

  get getTransactionType {
    return transactionType;
  }

  Map<String, String> toMap() {
    return {
      "itemCategory": itemCategory.toString(),
      "itemDescription": itemDescription.toString(),
      "itemCompany": itemCompany.toString(),
      "amount": amount.toString(),
      "date": date.toString(),
      "transactionType": transactionType.toString()
    };
  }

  TransactionObject.decoded(Map<String, dynamic> map) {
    switch (map["itemCategory"]) {
      case "ItemCategory.income":
        itemCategory = ItemCategory.income;
        break;
      case "ItemCategory.expense":
        itemCategory = ItemCategory.expense;
        break;
      case "ItemCategory.finance":
        itemCategory = ItemCategory.finance;
        break;
      case "ItemCategory.personal":
        itemCategory = ItemCategory.personal;
        break;
      case "ItemCategory.food":
        itemCategory = ItemCategory.food;
        break;
      case "ItemCategory.clothes":
        itemCategory = ItemCategory.clothes;
        break;
      case "ItemCategory.health":
        itemCategory = ItemCategory.health;
        break;
      case "ItemCategory.electronics":
        itemCategory = ItemCategory.electronics;
        break;
      case "ItemCategory.fun":
        itemCategory = ItemCategory.fun;
        break;
      case "ItemCategory.other":
        itemCategory = ItemCategory.other;
        break;

      default:
        itemCategory = ItemCategory.other;
        break;
    }

    itemDescription = map["itemDescription"]!;
    itemCompany = map["itemCompany"]!;
    amount = map["amount"]!;
    date = map["date"].split(" ")[0] + " " + map["date"].split(" ")[1];

    if (map["transactionType"]!.contains("inflow")) {
      transactionType = TransactionType.inflow;
    } else {
      transactionType = TransactionType.outflow;
    }
  }
}
