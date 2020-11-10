import 'package:expenseTracker/Model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SyncLineChart extends StatefulWidget {
  final List<Transaction> list;

  SyncLineChart(
    this.list,
  );
  @override
  _SyncLineChartState createState() => _SyncLineChartState();
}

class _SyncLineChartState extends State<SyncLineChart> {
  List<SplineAreaSeries<Data, DateTime>> _getSeries() {
    final List<Data> pieData = <Data>[];
    widget.list.forEach((element) {
      if (element.transactionType == TransactionType.Income) {
        pieData.add(Data(element.amount, element.date.millisecondsSinceEpoch));
      }
    });
    return <SplineAreaSeries<Data, DateTime>>[
      SplineAreaSeries(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.lightGreen, Colors.white],
              stops: [0.2, 0.8, 1]),
          dataSource: pieData,
          xValueMapper: (datum, index) =>
              DateTime.fromMicrosecondsSinceEpoch(datum.dateTime * 1000),
          // xValueMapper: (datum, index) => datum.total.toString(),
          yValueMapper: (datum, index) => datum.amount,
          markerSettings: MarkerSettings(
            width: 10,
            height: 10,
            isVisible: true,
          ),
          // dataLabelSettings: DataLabelSettings(isVisible: true),
          enableTooltip: true)
    ];
    // return <DoughnutSeries<Data, String>>[
    //   DoughnutSeries<Data, String>(
    //     // explode: true,
    //     // explodeIndex: 0,
    //     dataSource: pieData,
    //     xValueMapper: (Data data, _) => data.total.toString(),
    //     yValueMapper: (Data data, _) => data.total,
    //     // dataLabelMapper: (Data data, _) => data.text,
    //     cornerStyle: CornerStyle.bothCurve,
    //     pointColorMapper: (datum, index) => datum.color,
    //   ),
    // ];
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      series: _getSeries(),
      primaryYAxis: NumericAxis(interval: 500, isVisible: false),
      tooltipBehavior: TooltipBehavior(enable: true, header: 'Income'),
      primaryXAxis: DateTimeAxis(
        minimum: DateTime(2020, 11),
        maximum: DateTime(2020, 12, 0),
      ),
    );
  }
}

class Data {
  int amount;
  int dateTime;
  Data(this.amount, this.dateTime);
}
