import 'package:firebase_auth/firebase_auth.dart';
import 'package:moneymanager/data/transactionObject.dart';

// Global static user class.
class CurrentUser {
  static String firstName = "";
  static String lastName = "";
  static String signUpCode = "";
  static String email = "";
  static bool surveyCompleted = false;
  static User? firebaseUser;

  // Map<String, dynamic>.from(CurrentUser.getTransactions[i]) to get The Map For Later Use.
  static List<dynamic> transactions = [];
  static List<TransactionObject> transctionObjects = [];

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

  static bool get getSurveyStatus {
    return surveyCompleted;
  }

  static set setSurveyStatus(bool definedStatus) {
    surveyCompleted = definedStatus;
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
}
