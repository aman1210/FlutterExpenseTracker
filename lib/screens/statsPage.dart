import 'package:expenseTracker/Model/category.dart';
import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/categoryProvider.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Transaction> _transaction =
        Provider.of<TransactionProvider>(context).expense;
    List<CategoryModel> _category =
        Provider.of<CategoryProvider>(context).expenseCategory;
    var sum = 0;
    List<Transaction> _tM = [];
    _category.forEach((element) {
      print(element.categoryName);
    });

    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ..._tM.map((e) => Text(e.amount.toString())).toList(),
        ],
      ),
    );
  }
}

class Category {
  String name;
  int amount;
  Category({this.name, this.amount});
}
