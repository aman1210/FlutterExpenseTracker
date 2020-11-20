import 'package:expenseTracker/Model/category.dart';
import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/categoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  final List<Transaction> list;
  final double total;
  final TransactionType type;
  PieChart(this.list, this.total, this.type);
  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  List<CategoryModel> categories = [];
  @override
  void didUpdateWidget(covariant PieChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    categories = widget.type == TransactionType.Expense
        ? Provider.of<CategoryProvider>(context, listen: false).expenseCategory
        : Provider.of<CategoryProvider>(context, listen: false).incomeCategory;
  }

  @override
  void initState() {
    super.initState();
    categories = widget.type == TransactionType.Expense
        ? Provider.of<CategoryProvider>(context, listen: false).expenseCategory
        : Provider.of<CategoryProvider>(context, listen: false).incomeCategory;
  }

  @override
  Widget build(BuildContext context) {
    return _getDefaultPieChart();
  }

  SfCircularChart _getDefaultPieChart() {
    return SfCircularChart(
      legend: Legend(isVisible: true),
      series: _getDefaultPieSeries(),
    );
  }

  List<PieSeries<ChartSampleData, String>> _getDefaultPieSeries() {
    final List<ChartSampleData> pieData = <ChartSampleData>[];
    categories.forEach(
      (c) {
        int ctotal = 0;
        if (c.categoryName != "Other") {
          widget.list.forEach(
            (t) {
              if (t.category == c.categoryName) {
                ctotal += t.amount;
              }
            },
          );
          pieData.add(
            ChartSampleData(
                x: c.categoryName,
                y: ctotal / widget.total,
                text: ctotal == 0
                    ? ''
                    : '${((ctotal / widget.total) * 100).toStringAsPrecision(3)}%'),
          );
        }
      },
    );
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
          animationDuration: 1000,
          dataSource: pieData,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          startAngle: 90,
          endAngle: 90,
          dataLabelSettings: DataLabelSettings(isVisible: true)),
    ];
  }
}

class ChartSampleData {
  final dynamic x;
  final num y;
  final String text;
  ChartSampleData({this.x, this.y, this.text});
}
