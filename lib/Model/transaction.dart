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
      {@required this.transactionType,
      @required this.title,
      @required this.amount,
      @required this.category,
      @required this.icon,
      @required this.date,
      @required this.iconFamily,
      @required this.iconPackage});
}
