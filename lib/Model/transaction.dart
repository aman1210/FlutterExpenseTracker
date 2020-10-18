import 'package:flutter/cupertino.dart';

enum TransactionType {
  Income,
  Expense,
}

class Transaction {
  final String title;
  final int amount;
  final DateTime date;
  final String category;
  final int icon;
  final String iconFamily;
  final String iconPackage;
  final TransactionType transactionType;

  Transaction(
      {this.transactionType,
      this.title,
      this.amount,
      this.category,
      this.icon,
      this.date,
      @required this.iconFamily,
      @required this.iconPackage});
}
