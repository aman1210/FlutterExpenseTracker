import 'package:bezier_chart/bezier_chart.dart';
import 'package:expenseTracker/Model/transaction.dart';
import 'package:flutter/material.dart';

class BrezzierChart extends StatelessWidget {
  final List<Transaction> list;
  BrezzierChart(this.list);

  List<DataPoint<DateTime>> _expensepoints = [];
  List<DataPoint<DateTime>> _incomepoints = [];

  generate() {
    _expensepoints = [];
    _incomepoints = [];
    list.forEach((e) {
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
  Widget build(BuildContext context) {
    final toDate = DateTime.now();
    final fromDate = DateTime(DateTime.now().year - 1);
    generate();
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 4)
        ],
        color: Colors.deepPurple,
      ),
      // height: 400,
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
          footerHeight: 40.0,
        ),
      ),
    );
  }
}