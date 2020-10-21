import 'package:expenseTracker/Model/transaction.dart';

import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:expenseTracker/widgets/statsPage/barChart.dart';
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
  List<Transaction> _expenselist = [];
  List<Transaction> _incomeList = [];
  List<Transaction> _list = [];

  generate(List<Transaction> t) {
    _expenselist.clear();
    _incomeList.clear();
    t.forEach((e) {
      if (e.transactionType == TransactionType.Expense) {
        _expenselist.add(e);
      } else {
        _incomeList.add(e);
      }
    });
    setState(() {});
  }

  changeDate() {
    _list.clear();
    _list = Provider.of<TransactionProvider>(context, listen: false)
        .getTransactionInRange(date);
    print(_list.length);

    generate(_list);
  }

  @override
  void initState() {
    super.initState();
    changeDate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple[400],
      width: double.infinity,
      height: double.maxFinite,
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
                  changeDate();
                },
              );
            },
          ),
          BarChart(
            date: date,
            list: _expenselist,
          ),
          Expanded(
            child: Center(
              child: Text('hello'),
            ),
          )
        ],
      ),
    );
  }
}
