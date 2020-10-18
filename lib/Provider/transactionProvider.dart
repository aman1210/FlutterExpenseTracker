import 'package:flutter/material.dart';
import 'package:expenseTracker/Model/transaction.dart';

class TransactionProvider with ChangeNotifier {
  String title;
  int amount;
  DateTime date = DateTime.now();
  int iconCode;
  String category;
  String iconFamily;
  String iconPackage;
  int spent = 0;
  int earned = 0;
  int balance = 0;

  List<Transaction> transaction = [];

  get totalBalance {
    transaction.forEach((element) {
      if (element.transactionType == TransactionType.Income) {
        earned += element.amount;
      } else {
        spent += element.amount;
      }
    });
    balance = earned - spent;
  }

  setTitle(String newtitle, int newamount) {
    title = newtitle;
    amount = newamount;
  }

  setCategory(String newCategory, int newicon, String iconF, String iconP) {
    category = newCategory;
    iconCode = newicon;
    iconFamily = iconF;
    iconPackage = iconP;
    print(newicon);
    print(iconF);
    print(iconP);
  }

  setDate(DateTime newdateTime) {
    date = newdateTime;
  }

  cancelTransaction() {
    title = null;
    amount = null;
    date = DateTime.now();
    iconCode = null;
    category = null;
  }

  String addTransaction(TransactionType _t) {
    if (title == null) {
      return 'Please enter the title';
    } else if (amount == null || amount <= 0) {
      return 'Please enter a valid amount';
    } else if (category == null) {
      return 'Please select a category';
    }
    transaction.add(
      new Transaction(
          amount: amount,
          category: category,
          icon: iconCode,
          iconFamily: iconFamily,
          iconPackage: iconPackage,
          date: date,
          title: title,
          transactionType: _t),
    );
    if (_t == TransactionType.Income) {
      earned += amount;
    } else {
      spent += amount;
    }
    balance = earned - spent;
    notifyListeners();
    return '';
  }
}
