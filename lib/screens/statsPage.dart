import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:expenseTracker/widgets/statsPage/brezzerChart.dart';
import 'package:expenseTracker/widgets/statsPage/pieChartController.dart';

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<Transaction> _list =
        Provider.of<TransactionProvider>(context, listen: false).transaction;
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        centerTitle: true,
      ),
      body: Container(
        // color: Colors.purple[50],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 350,
                child: BrezzierChart(
                  _list,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              PIE(size),
            ],
          ),
        ),
      ),
    );
  }
}
