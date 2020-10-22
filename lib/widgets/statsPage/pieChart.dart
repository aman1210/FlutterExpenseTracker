import 'package:expenseTracker/Model/category.dart';
import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/categoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  final List<Transaction> list;
  final double total;
  PieChart(this.list, this.total);
  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  List<CategoryModel> categories = [];
  @override
  void initState() {
    super.initState();
    categories =
        Provider.of<CategoryProvider>(context, listen: false).expenseCategory;
  }

  @override
  Widget build(BuildContext context) {
    return _getDefaultPieChart();
  }

  /// Returns the circular  chart with pie series.
  SfCircularChart _getDefaultPieChart() {
    var isCardView = false;
    return SfCircularChart(
      title: ChartTitle(text: isCardView ? '' : 'Sales by sales person'),
      legend: Legend(isVisible: !isCardView),
      series: _getDefaultPieSeries(),
    );
  }

  /// Returns the pie series.
  List<PieSeries<ChartSampleData, String>> _getDefaultPieSeries() {
    final List<ChartSampleData> pieData = <ChartSampleData>[];
    categories.forEach((c) {
      int ctotal = 0;
      widget.list.forEach((t) {
        if (t.category == c.categoryName) {
          ctotal += t.amount;
        }
      });
      pieData.add(
        ChartSampleData(
            x: c.categoryName, y: ctotal / widget.total, text: '$ctotal'),
      );
    });
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
          explode: true,
          explodeIndex: 0,
          explodeOffset: '10%',
          dataSource: pieData,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          startAngle: 90,
          endAngle: 90,
          explodeAll: true,
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
