import 'package:expenseTracker/widgets/statsPage/sync_line_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';

import 'package:expenseTracker/widgets/statsPage/pieChartController.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  var date = DateTime.now();
  List<Transaction> _expenselist = [];
  List<Transaction> _incomeList = [];
  var expensetotal = 0.0;
  var incometotal = 0.0;
  var right = false;

  changeDirection() {
    setState(() {
      right = !right;
    });
  }

  generate(List<Transaction> t) {
    _expenselist.clear();
    _incomeList.clear();
    t.forEach((e) {
      if (e.transactionType == TransactionType.Expense) {
        _expenselist.add(e);
        expensetotal += e.amount;
      } else {
        _incomeList.add(e);
        incometotal += e.amount;
      }
    });
    setState(() {});
  }

  changeDate(int n) {
    setState(() {
      date = DateTime(date.year, date.month + n);
      incometotal = 0;
      expensetotal = 0;
      var list = Provider.of<TransactionProvider>(context, listen: false)
          .getTransactionInRange(date);
      generate(list);
    });
  }

  @override
  void initState() {
    super.initState();
    var list = Provider.of<TransactionProvider>(context, listen: false)
        .getTransactionInRange(date);
    generate(list);
  }

  Container buildPieHeader(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black38),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(FontAwesomeIcons.arrowCircleLeft),
            onPressed: () {
              changeDate(-1);
            },
          ),
          Expanded(
            child: Text(
              '${DateFormat.yMMMM().format(date)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.arrowCircleRight),
            onPressed: () {
              changeDate(1);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            buildPieHeader('Expense'),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              width: size.width - 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: right ? Colors.green : Colors.blue),
              ),
              alignment: Alignment.center,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        right = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: 40,
                      width: right
                          ? (size.width - 20) / 3
                          : ((size.width - 20) / 3) * 2,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      decoration: !right
                          ? BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(40))
                          : null,
                      child: Center(
                        child: Text(
                          'Expenses',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'TimeBurner'),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        right = true;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: 40,
                      width: !right
                          ? (size.width - 20) / 3
                          : ((size.width - 20) / 3) * 2,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      decoration: !right
                          ? null
                          : BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(40)),
                      child: Center(
                        child: Container(
                          child: Text(
                            'Income',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'TimeBurner',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                height: 300,
                child: SyncLineChart(right ? _incomeList : _expenselist, date,
                    right ? Colors.green : Colors.blue),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            PIE(
              size: size,
              right: right,
              date: date,
              expenselist: _expenselist,
              incomeList: _incomeList,
              incometotal: incometotal,
              expensetotal: expensetotal,
            ),
          ],
        ),
      ),
    );
  }
}
