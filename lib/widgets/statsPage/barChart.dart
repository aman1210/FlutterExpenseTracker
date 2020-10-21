import 'package:expenseTracker/Model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChart extends StatefulWidget {
  final DateTime date;
  final List<Transaction> list;
  BarChart({this.date, this.list});
  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  List<charts.Series<TransactionChart, String>> _series;
  List<TransactionChart> data = [];

  generate() {
    var start = DateTime(widget.date.year, widget.date.month, 1);
    var endNum = DateTime(widget.date.year, widget.date.month + 1, 0)
        .compareTo(DateTime.now());
    var end = endNum > 0
        ? DateTime.now()
        : DateTime(widget.date.year, widget.date.month + 1, 0);
    data.clear();
    for (var i = start.day; i <= end.day; i++) {
      var sum = 0;
      widget.list.map(
        (t) {
          if (t.date.day == i) {
            sum += t.amount;
          }
        },
      ).toList();
      data.add(
        TransactionChart(
          i.toString(),
          sum,
          sum <= 500
              ? Color(0xff28abb9)
              : sum <= 1000
                  ? Color(0xfff6830f)
                  : Color(0xffbb2205),
        ),
      );
    }
    _series.clear();
    _series.add(
      charts.Series(
        id: 'Transactions',
        data: data,
        domainFn: (TransactionChart t, _) => t.date,
        measureFn: (TransactionChart t, _) => t.amount,
        colorFn: (TransactionChart t, _) =>
            charts.ColorUtil.fromDartColor(t.colorval),
        labelAccessorFn: (TransactionChart t, _) => t.amount == 0 ? '' : '',
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _series = List<charts.Series<TransactionChart, String>>();
    generate();
  }

  @override
  void didUpdateWidget(covariant BarChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    _series = List<charts.Series<TransactionChart, String>>();
    generate();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 8.0, top: 8, bottom: 10, right: 5),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1.5 * 30 * data.length,
              child: charts.BarChart(
                _series,
                animate: true,
                barRendererDecorator: new charts.BarLabelDecorator<String>(
                    labelPosition: charts.BarLabelPosition.inside,
                    labelAnchor: charts.BarLabelAnchor.middle),
                domainAxis: new charts.OrdinalAxisSpec(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionChart {
  String date;
  int amount;
  Color colorval;
  TransactionChart(this.date, this.amount, this.colorval);
}
