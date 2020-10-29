import 'package:expenseTracker/Provider/profileProvider.dart';
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
                gradient: Provider.of<ProfileProvider>(context).isDark == true
                    ? LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.grey[800],
                          Colors.black,
                        ],
                        stops: [0.1, 0.9],
                      )
                    : LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.blue[800],
                          Colors.deepPurple,
                        ],
                        stops: [0.1, 0.9],
                      ),
              ),
              height: 380,
              child: Stack(
                // fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  BrezzierChart(
                    _list,
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.touch_app,
                              size: 20,
                              color: Colors.white,
                            ),
                            Text(
                              'Tap to disable indicator',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.zoom_in,
                              size: 20,
                              color: Colors.white,
                            ),
                            Text(
                              'Pinch to zoom-in and zoom-out(when indicator is disabled)',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.touch_app,
                              size: 20,
                              color: Colors.white,
                            ),
                            Text(
                              'Hold to enable and drag indicator',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
