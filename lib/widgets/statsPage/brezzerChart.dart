import 'package:bezier_chart/bezier_chart.dart';
import 'package:expenseTracker/Model/transaction.dart';
import 'package:flutter/material.dart';

class BrezzierChart extends StatefulWidget {
  final List<Transaction> list;
  BrezzierChart(this.list);
  @override
  _BrezzierChartState createState() => _BrezzierChartState();
}

class _BrezzierChartState extends State<BrezzierChart> {
  List<DataPoint<DateTime>> _expensepoints = [];
  List<DataPoint<DateTime>> _incomepoints = [];

  generate() {
    _expensepoints = [];
    _incomepoints = [];
    widget.list.forEach((e) {
      if (e.transactionType == TransactionType.Expense) {
        _expensepoints.add(
            DataPoint<DateTime>(value: e.amount.toDouble(), xAxis: e.date));
      } else {
        _incomepoints.add(
            DataPoint<DateTime>(value: e.amount.toDouble(), xAxis: e.date));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    generate();
  }

  var currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final toDate = DateTime.now();
    final fromDate = DateTime(DateTime.now().year - 1);

    return Container(
      // margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 5)
        ],
        color: Colors.deepPurple,
      ),
      height: 350,
      width: MediaQuery.of(context).size.width,
      child: BezierChart(
        fromDate: fromDate,
        bezierChartScale: BezierChartScale.WEEKLY,
        toDate: toDate,
        selectedDate: toDate,
        series: [
          BezierLine(
            label: "Income",
            onMissingValue: (value) {
              return 0;
            },
            data: _incomepoints,
            lineColor: Colors.green[200],
          ),
          BezierLine(
            label: "Expense",
            onMissingValue: (dateTime) {
              return 0;
            },
            data: _expensepoints,
            lineColor: Colors.blue[300],
          ),
        ],
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 3.0,
          verticalIndicatorColor: Colors.black26,
          showVerticalIndicator: true,
          verticalIndicatorFixedPosition: false,
          backgroundGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple[300],
              Colors.deepPurple,
            ],
          ),
          displayDataPointWhenNoValue: true,
          pinchZoom: true,
          bubbleIndicatorColor: Colors.white,
          backgroundColor: Colors.deepPurple,
          footerHeight: 50.0,
        ),
      ),
    );
  }
}
