import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:expenseTracker/widgets/statsPage/pieChart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PIE extends StatefulWidget {
  final Size size;
  PIE(this.size);
  @override
  _PIEState createState() => _PIEState();
}

class _PIEState extends State<PIE> {
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

  @override
  Widget build(BuildContext context) {
    return right == false
        ? Card(
            elevation: 20,
            child: Column(
              children: [
                buildPieHeader('Expense'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _expenselist.length == 0
                        ? Image.asset(
                            'assets/images/noData.png',
                            width: widget.size.width - 60,
                          )
                        : Expanded(
                            child: PieChart(_expenselist, expensetotal,
                                TransactionType.Expense),
                          ),
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      icon: Icon(Icons.chevron_right),
                      onPressed: () {
                        changeDirection();
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        : Card(
            elevation: 20,
            child: Column(
              children: [
                buildPieHeader('Income'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      icon: Icon(Icons.chevron_left),
                      onPressed: () {
                        changeDirection();
                      },
                    ),
                    _incomeList.length == 0
                        ? Image.asset(
                            'assets/images/noData.png',
                            width: widget.size.width - 60,
                          )
                        : Expanded(
                            child: PieChart(
                              _incomeList,
                              incometotal,
                              TransactionType.Income,
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
          IconButton(
            icon: Icon(FontAwesomeIcons.arrowCircleLeft),
            onPressed: () {
              changeDate(-1);
            },
          ),
          Text(
            '$title in ${DateFormat.yMMM().format(date)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
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
}
