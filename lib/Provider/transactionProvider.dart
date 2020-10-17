import 'package:flutter/material.dart';
import 'package:expenseTracker/Model/transaction.dart';

class TransactionProvider with ChangeNotifier {
  String title;
  int amount;
  DateTime date = DateTime.now();
  IconData icon;
  String category;

  setTitle(String newtitle, int newamount) {
    title = newtitle;
    amount = newamount;
  }

  setCategory(String newCategory, String newicon) {}
}
