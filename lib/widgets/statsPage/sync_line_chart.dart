import 'package:expenseTracker/Model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SyncLineChart extends StatelessWidget {
  final List<Transaction> list;

  SyncLineChart(
    this.list,
  );

  List<SplineAreaSeries<Data, DateTime>> _getSeries() {
    final List<Data> pieData = <Data>[];
    for (var i = DateTime(2020, 11, 1).day;
        i <= DateTime(2020, 12, 0).day;
        i++) {
      int sum = 0;
      list.forEach((element) {
        if (element.date.day == i &&
            element.transactionType == TransactionType.Income) {
          sum += element.amount;
        }
      });
      if (sum != 0) {
        pieData.add(Data(sum, DateTime(2020, 11, i).millisecondsSinceEpoch));
      }
    }
    return <SplineAreaSeries<Data, DateTime>>[
      SplineAreaSeries(
          animationDuration: 5,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.lightGreen, Colors.white],
              stops: [0.2, 0.8, 1]),
          dataSource: pieData,
          xValueMapper: (datum, index) =>
              DateTime.fromMicrosecondsSinceEpoch(datum.dateTime * 1000),
          yValueMapper: (datum, index) => datum.amount,
          markerSettings: MarkerSettings(
            isVisible: true,
          ),
          enableTooltip: true)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      series: _getSeries(),
      primaryYAxis: NumericAxis(interval: 500, associatedAxisName: 'Amount'),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        header: 'Income',
      ),
      primaryXAxis: DateTimeAxis(
          minimum: DateTime(2020, 11),
          maximum: DateTime(2020, 12, 0),
          associatedAxisName: 'Date'),
    );
  }
}

class Data {
  int amount;
  int dateTime;
  Data(this.amount, this.dateTime);
}
