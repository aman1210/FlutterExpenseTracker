import 'package:flutter/material.dart';
import 'package:expenseTracker/Model/transaction.dart';

class TransactionProvider with ChangeNotifier {
  String title;
  int amount;
  DateTime date = DateTime.now();
  IconData icon;
  String category;

  void setTitle(String title, int amount) {
    title = title;
    amount = amount;
  }
}
