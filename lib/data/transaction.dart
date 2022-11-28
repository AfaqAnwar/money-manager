enum TransactionType { outflow, inflow }

enum ItemCategory { income, expense, food, fun, other }

// Transaction Object Class
class Transaction {
  final ItemCategory itemCategory;
  final String itemCategoryName;
  final String itemName;
  final String amount;
  final String date;
  final String categoryImage;
  final TransactionType transactionType;

  const Transaction(
    this.itemCategory,
    this.itemCategoryName,
    this.itemName,
    this.amount,
    this.date,
    this.categoryImage,
    this.transactionType,
  );
}
