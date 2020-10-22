import 'package:expenseTracker/Model/transaction.dart';

import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:expenseTracker/widgets/statsPage/brezzerChart.dart';
import 'package:expenseTracker/widgets/statsPage/pieChart.dart';
import 'package:flutter/material.dart';
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
  var expensetotal = 0.0;
  var incometotal = 0.0;

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

  changeDate() {
    _list.clear();
    _list =
        Provider.of<TransactionProvider>(context, listen: false).transaction;
    generate(_list);
  }

  @override
  void initState() {
    super.initState();
    changeDate();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.purple[50],
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            BrezzierChart(
              _list,
            ),
            SizedBox(
              height: 20,
            ),
            Card(
                child: Row(
              children: [
                Expanded(child: PieChart(_expenselist, expensetotal)),
                IconButton(icon: Icon(Icons.chevron_right), onPressed: () {})
              ],
            )),
          ],
        ),
      ),
    );
  }
}
