import 'package:expenseTracker/Provider/profileProvider.dart';
import 'package:expenseTracker/widgets/statsPage/sync_line_chart.dart';
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

        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //       blurRadius: 10,
                  //       offset: Offset(0, 5),
                  //       color: Colors.black38)
                  // ],
                  // color: Color(0xffa8e063),
                  // gradient: Provider.of<ProfileProvider>(context).isDark == true
                  //     ? LinearGradient(
                  //         begin: Alignment.topRight,
                  //         end: Alignment.bottomLeft,
                  //         colors: [
                  //           Colors.grey[800],
                  //           Colors.black,
                  //         ],
                  //         stops: [0.1, 0.9],
                  //       )
                  //     : null,
                  ),
              height: 380,

              // BrezzierChart(
              //   _list,
              // ),
              child: SyncLineChart(_list),
            ),
            SizedBox(
              height: 10,
            ),
            PIE(size),
          ],
        ),
      ),
    );
  }
}
