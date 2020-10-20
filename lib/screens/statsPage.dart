import 'package:expenseTracker/Model/category.dart';
import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/categoryProvider.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  var date = DateTime.now();
  List<charts.Series<TransactionChart, num>> _series;
  List<Transaction> _list = [];
  List<TransactionChart> data = [];

  generate() {
    var start = DateTime(date.year, date.month, 1);
    var endNum =
        DateTime(date.year, date.month + 1, 0).compareTo(DateTime.now());
    var end =
        endNum > 0 ? DateTime.now() : DateTime(date.year, date.month + 1, 0);
    data.clear();
    data.add(TransactionChart(0, 0));
    var sum = 0;
    for (var i = start.day; i <= end.day; i++) {
      var x = 0;
      _list.map(
        (t) {
          if (t.transactionType == TransactionType.Expense &&
              t.date.isAfter(start) &&
              t.date.isBefore(end) &&
              t.date.day == i) {
            sum += t.amount;
            x += t.amount;
          }
        },
      ).toList();
      if (x > 0) data.add(TransactionChart(i, sum));
    }
    String month = DateFormat.MMM().format(date);
    _series.clear();
    _series.add(
      charts.Series(
        id: 'Transactions',
        data: data,
        domainFn: (TransactionChart t, _) => t.date,
        measureFn: (TransactionChart t, _) => t.amount,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _list =
        Provider.of<TransactionProvider>(context, listen: false).transaction;

    _series = List<charts.Series<TransactionChart, num>>();
    generate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 100,
          ),
          RaisedButton(
            child: Text('change range'),
            onPressed: () async {
              final DateTime picked = await showMonthPicker(
                  context: context,
                  initialDate: date,
                  locale: Locale('en', ''));
              setState(
                () {
                  date = picked;
                  generate();
                },
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: charts.LineChart(
                _series,
                animate: true,
                animationDuration: Duration(milliseconds: 300),
                defaultRenderer: charts.LineRendererConfig(
                  includeArea: true,
                  includePoints: true,
                  includeLine: true,
                ),
                behaviors: [
                  charts.ChartTitle(
                    'Spent',
                    behaviorPosition: charts.BehaviorPosition.bottom,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionChart {
  num date;
  int amount;
  TransactionChart(this.date, this.amount);
}
