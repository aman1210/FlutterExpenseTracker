import 'package:flutter/material.dart';
import 'package:expenseTracker/Model/transaction.dart';

class TransactionProvider with ChangeNotifier {
  String title;
  int amount;
  DateTime date = DateTime.now();
  int iconCode;
  String category;

  setTitle(String newtitle, int newamount) {
    title = newtitle;
    amount = newamount;
  }

  setCategory(String newCategory, int newicon) {
    category = newCategory;
    iconCode = newicon;
  }

  setDate(DateTime newdateTime) {
    date = newdateTime;
  }

  cancelTransaction() {
    title = '';
    amount = null;
    date = DateTime.now();
    iconCode = null;
    category = '';
  }

  void addTransaction() {
    print(title);
    print(amount);
    print(date);
    print(iconCode);
    print(category);
  }
}
