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
      case "income":
        itemCategory = ItemCategory.income;
        break;
      case "expense":
        itemCategory = ItemCategory.expense;
        break;
      case "finance":
        itemCategory = ItemCategory.finance;
        break;
      case "personal":
        itemCategory = ItemCategory.personal;
        break;
      case "food":
        itemCategory = ItemCategory.food;
        break;
      case "clothes":
        itemCategory = ItemCategory.clothes;
        break;
      case "health":
        itemCategory = ItemCategory.health;
        break;
      case "electronics":
        itemCategory = ItemCategory.electronics;
        break;
      case "fun":
        itemCategory = ItemCategory.electronics;
        break;
      case "other":
        itemCategory = ItemCategory.other;
        break;
    }

    itemDescription = map["itemDescription"]!;
    itemCompany = map["itemCompany"]!;
    amount = map["amount"]!;
    date = map["date"]!;

    if (map["transactionType"]!.contains("inflow")) {
      transactionType = TransactionType.inflow;
    } else {
      transactionType = TransactionType.outflow;
    }
  }
}
