import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/widgets/statsPage/pieChart.dart';

class PIE extends StatelessWidget {
  final Size size;
  final List<Transaction> expenselist;
  final List<Transaction> incomeList;
  final expensetotal;
  final incometotal;
  final bool right;
  final DateTime date;
  PIE(
      {this.size,
      this.expenselist,
      this.incomeList,
      this.date,
      this.expensetotal,
      this.right,
      this.incometotal});
  // var date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Column(
        children: [
          buildPieHeader('Category Wise'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              expenselist.length == 0
                  ? Image.asset(
                      'assets/images/noData.png',
                      width: size.width - 150,
                    )
                  : Expanded(
                      child: PieChart(
                        right ? incomeList : expenselist,
                        right ? incometotal : expensetotal,
                        right
                            ? TransactionType.Income
                            : TransactionType.Expense,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildPieHeader(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black38),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$title',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
