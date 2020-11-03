import 'package:expenseTracker/helper/transaction_helper.dart';
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
  List<Transaction> expense = [];

  totalBalance(int month) {
    balance = 0;
    spent = 0;
    earned = 0;
    transaction.forEach((element) {
      if (element.date.month == month) {
        if (element.transactionType == TransactionType.Income) {
          earned += element.amount;
        } else {
          spent += element.amount;
        }
      }
    });
    balance = earned - spent;
    notifyListeners();
  }

  setTitle(String newtitle) {
    title = newtitle;
  }

  setAmount(int newAmount) {
    amount = newAmount;
  }

  setCategory(String newCategory, int newicon, String iconF, String iconP) {
    category = newCategory;
    iconCode = newicon;
    iconFamily = iconF;
    iconPackage = iconP;
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

  Future<void> fetchAndSetTransaction() async {
    final tList = await TransactionHelper.getData();
    List<Transaction> _t = [];
    _t = tList.map((e) {
      var t = Transaction(
        transactionType:
            e['type'] == 0 ? TransactionType.Income : TransactionType.Expense,
        title: e['title'],
        amount: e['amount'],
        category: e['category'],
        icon: e['iconCode'],
        date: DateTime.parse(e['date']),
        iconFamily: e['iconFamily'],
        iconPackage: e['iconPackage'],
      );
      if (e['type'] == 1) {
        expense.add(t);
      }

      return t;
    }).toList();
    transaction = _t.reversed.toList();
    totalBalance(DateTime.now().month);
    notifyListeners();
  }

  String addTransaction(TransactionType _t) {
    if (title == null) {
      return 'Please enter the title';
    } else if (amount == null) {
      return 'Please enter the amount';
    } else if (amount <= 0) {
      return 'Please enter a number greater than 0';
    } else if (category == null) {
      return 'Please select a category';
    }
    transaction.insert(
      0,
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
    totalBalance(DateTime.now().month);
    notifyListeners();
    TransactionHelper.insert(
      title: title,
      amount: amount,
      category: category,
      date: date.toIso8601String(),
      iconCode: iconCode,
      iconFamily: iconFamily,
      iconPackage: iconPackage,
      type: _t.index,
    );
    cancelTransaction();
    return '';
  }

  Future<void> delete(DateTime date) async {
    transaction.removeWhere((element) => element.date == date);
    TransactionHelper.delete(date.toIso8601String());
    totalBalance(date.month);
  }

  List<Transaction> getTransactionInRange(DateTime d) {
    var start = DateTime(d.year, d.month, 1);
    var endNum = DateTime(d.year, d.month + 1, 0).compareTo(DateTime.now());
    var end = endNum > 0 ? DateTime.now() : DateTime(d.year, d.month + 1, 0);
    List<Transaction> list = [];
    transaction.forEach((t) {
      if (t.date.isAfter(start) && t.date.isBefore(end)) {
        list.add(t);
      }
    });
    return list;
  }
}
