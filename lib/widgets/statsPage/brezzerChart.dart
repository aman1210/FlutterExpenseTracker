import 'package:bezier_chart/bezier_chart.dart';
import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrezzierChart extends StatelessWidget {
  final List<Transaction> list;

  BrezzierChart(
    this.list,
  );

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
      constraints: BoxConstraints(maxHeight: 300),
      decoration: BoxDecoration(
        boxShadow: [
          // BoxShadow(
          //   color: Colors.black38,
          //   offset: Offset(0, 15),
          //   blurRadius: 4,
          //   spreadRadius: 0,
          // )
        ],
        // color: Colors.deepPurple,
      ),
      height: 300,
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
            lineColor: Theme.of(context).accentColor,
          ),
          BezierLine(
            label: "Expense",
            onMissingValue: (dateTime) {
              return 0;
            },
            data: _expensepoints,
            lineColor: Theme.of(context).primaryColor,
          ),
        ],
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 3.0,
          verticalIndicatorColor: Colors.black26,
          showVerticalIndicator: true,
          verticalIndicatorFixedPosition: false,
          displayDataPointWhenNoValue: true,
          // backgroundGradient:
          //     Provider.of<ProfileProvider>(context).isDark == true
          //         ? LinearGradient(
          //             begin: Alignment.topRight,
          //             end: Alignment.bottomLeft,
          //             colors: [
          //               Colors.grey[800],
          //               Colors.black,
          //             ],
          //             stops: [0.1, 0.9],
          //           )
          //         : LinearGradient(
          //             begin: Alignment.topCenter,
          //             end: Alignment.bottomCenter,
          //             colors: [
          //               Color(0xffa8e063),
          //               Color(0xff56ab2f),
          //             ],
          //             stops: [0.3, 0.9],
          //           ),
          pinchZoom: true,
          // bubbleIndicatorColor: Colors.white,
          // backgroundColor: Theme.of(context).brightness == Brightness.dark
          //     ? Theme.of(context).primaryColor
          //     : Colors.white,
          footerHeight: 40.0,
        ),
      ),
    );
  }
}
