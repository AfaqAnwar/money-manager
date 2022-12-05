import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moneymanager/data/transactionObject.dart';

// Global static user class.
class CurrentUser {
  static String firstName = "";
  static String lastName = "";
  static String signUpCode = "";
  static String email = "";
  static String accountType = "";
  static bool surveyCompleted = false;
  static User? firebaseUser;

  // Map<String, dynamic>.from(CurrentUser.getTransactions[i]) to get The Map For Later Use.
  static List<dynamic> transactions = [];
  static List<TransactionObject> transctionObjects = [];
  static List<Map<String, List<TransactionObject>>> connectedUsers = [];
  static Map<int, int> monthlyIncome = {};

  static int userAge = 0;
  static String userExperience = "";
  static double userWeeklyEarning = 0.0;
  static double userWeeklySpending = 0.0;
  static double userLifetimeIncome = 0.0;
  static double userLifetimeExpense = 0.0;
  static double totalBalance = 0.0;

  CurrentUser();

  static User? get getFireUser {
    return firebaseUser;
  }

  static set setFireUser(User? u) {
    firebaseUser = u;
  }

  static String get getFirstName {
    return firstName;
  }

  static set setFirstName(String fName) {
    firstName = fName;
  }

  static String get getLastName {
    return lastName;
  }

  static set setLastName(String lName) {
    lastName = lName;
  }

  static String get getCode {
    return signUpCode;
  }

  static set setCode(String code) {
    signUpCode = code;
  }

  static String get getEmail {
    return email;
  }

  static set setEmail(String emailString) {
    email = emailString;
  }

  static String get getAccountType {
    return accountType;
  }

  static set setAccountType(String type) {
    accountType = type;
  }

  static bool get getSurveyStatus {
    return surveyCompleted;
  }

  static set setSurveyStatus(bool definedStatus) {
    surveyCompleted = definedStatus;
  }

  static Map<int, int> get getMonthlyIncomeMap {
    return monthlyIncome;
  }

  static int get getAge {
    return userAge;
  }

  static set setAge(int definedAge) {
    userAge = definedAge;
  }

  static String get getExperience {
    return userExperience;
  }

  static set setExperience(String definedExperience) {
    userExperience = definedExperience;
  }

  static double get getWeeklyEarning {
    return userWeeklyEarning;
  }

  static set setWeeklyEarning(double definedWeeklyEarning) {
    userWeeklyEarning = definedWeeklyEarning;
  }

  static double get getWeeklySpending {
    return userWeeklySpending;
  }

  static set setWeeklySpending(double definedWeeklySpending) {
    userWeeklyEarning = definedWeeklySpending;
  }

  static set setTransactions(List<dynamic> transactionList) {
    transactions = transactionList;
  }

  static List<dynamic> get getTransactions {
    return transactions;
  }

  static set setTransctionObjectList(
      List<TransactionObject> transactionObjectList) {
    transctionObjects = transactionObjectList;
  }

  static List<TransactionObject> get getTransactionObjects {
    return transctionObjects;
  }

  static get getUserLifetimeIncome {
    return userLifetimeIncome;
  }

  static set setUserLifetimeIncome(double income) {
    userLifetimeIncome = income;
  }

  static get getUserLifetimeExpense {
    return userLifetimeExpense;
  }

  static set setUserLifetimeExpense(double expense) {
    userLifetimeExpense = expense;
  }

  static get getTotalBalance {
    return totalBalance;
  }

  static void updateTotalBalance() {
    totalBalance = userLifetimeIncome - userLifetimeExpense;
  }

  static void updateUserIncomeAndExpense() {
    userLifetimeIncome = 0;
    userLifetimeExpense = 0;
    for (TransactionObject i in transctionObjects) {
      if (i.transactionType == TransactionType.inflow) {
        userLifetimeIncome = userLifetimeIncome + double.parse(i.amount);
      } else {
        userLifetimeExpense = userLifetimeExpense + double.parse(i.amount);
      }
    }
  }

  static updateBasicUserDetails() async {
    CurrentUser.firebaseUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('users')
        .doc(CurrentUser.firebaseUser?.uid)
        .get();
    CurrentUser.setFirstName = data.get('first name');
    CurrentUser.setLastName = data.get('last name');
    CurrentUser.setEmail = data.get('email');
    CurrentUser.setCode = data.get('sign up code');
    CurrentUser.setSurveyStatus = data.get('survey completed');
    CurrentUser.setAge = data.get('age');
    CurrentUser.setExperience = data.get('experience');
    CurrentUser.setWeeklyEarning = double.parse(data.get('weekly income'));
    CurrentUser.setWeeklySpending = double.parse(data.get('weekly spending'));
  }

  static updateConnectedUsers() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users');

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    List<dynamic> allData =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    for (int i = 0; i < allData.length; i++) {
      var map = Map<String, dynamic>.from(allData[i]);
      var userMap = <String, List<TransactionObject>>{};
      if (map.values.elementAt(10) == signUpCode &&
          map.values.elementAt(1) == "Student" &&
          map.values.elementAt(7) != email) {
        var nameKey = map.values.elementAt(0) + " " + map.values.elementAt(2);
        List<TransactionObject> tranasctionObjectsList = [];
        var transactionList = map.values.elementAt(9);

        for (int i = 0; i < transactionList.length; i++) {
          TransactionObject transaction =
              TransactionObject.decoded(transactionList[i]);
          tranasctionObjectsList.add(transaction);
        }
        userMap.putIfAbsent(nameKey, () => tranasctionObjectsList);
        connectedUsers.add(userMap);
      }
    }
  }

  static Future<bool> noCodeMatch() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('users');

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    List<dynamic> allData =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    for (int i = 0; i < allData.length; i++) {
      var map = Map<String, dynamic>.from(allData[i]);

      if (map.values.elementAt(10) == signUpCode &&
          map.values.elementAt(1) == "Student" &&
          map.values.elementAt(7) != email) {
        return false;
      }
    }

    return true;
  }

  static void parseTransactionsMonthly() {
    monthlyIncome.clear();
    for (int i = 0; i < transctionObjects.length; i++) {
      var currentTransaction = transctionObjects[i];
      var monthOfCurrentTransaction = currentTransaction.date.split(" ")[0];
      var yearOfCurrentTransaction = currentTransaction.getDateYear;

      DateTime now = DateTime.now();
      DateTime date = DateTime(now.year, now.month, now.day);
      String currentYear =
          date.toString().replaceAll("00:00:00.000", "").split("-")[0];

      int month = 0;
      switch (monthOfCurrentTransaction) {
        case "Jan":
          month = 1;
          break;
        case "Feb":
          month = 2;
          break;
        case "Mar":
          month = 3;
          break;
        case "Apr":
          month = 4;
          break;
        case "May":
          month = 5;
          break;
        case "June":
          month = 6;
          break;
        case "July":
          month = 7;
          break;
        case "Aug":
          month = 8;
          break;
        case "Sep":
          month = 9;
          break;
        case "Oct":
          month = 10;
          break;
        case "Nov":
          month = 11;
          break;
        case "Dec":
          month = 12;
          break;
      }
      if (currentTransaction.getTransactionType == TransactionType.inflow &&
          currentTransaction.getDateYear == currentYear) {
        if (monthlyIncome.containsKey(month)) {
          var currentIncome = 0;
          currentIncome = monthlyIncome[month]!;
          currentIncome += int.parse(currentTransaction.getItemAmount);
          monthlyIncome.update(month, (value) => currentIncome);
        } else {
          monthlyIncome.putIfAbsent(
              month, () => int.parse(currentTransaction.getItemAmount));
        }
      }
    }
  }
}
