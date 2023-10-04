import 'package:flutter/material.dart';
import 'package:flutter_dashboard/data/models/data.dart';
import 'package:flutter_dashboard/presentation/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnChart extends StatefulWidget {
  List<List<String>>? data;
  List<String>? labelsOfCom;
  ColumnChart({this.data, this.labelsOfCom, super.key});

  @override
  State<ColumnChart> createState() => _ColumnChartState();
}

class _ColumnChartState extends State<ColumnChart> {
  late List<ExpenseData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  Color getColorOfCol(String e) {
    switch (e) {
      case "СНГ":
        return ThemeColors().sng;
      case "Внутренний рынок":
        return ThemeColors().innerMarket;
      case "Что-то":
        return ThemeColors().justAddSmth;
      case "Внешний рынок":
        return ThemeColors().outMarket;
    }

    return ThemeColors().export;
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: "Распределение по рынкам"),
      legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        ...widget.labelsOfCom!.map(
          (e) => StackedColumn100Series<ExpenseData, String>(
            dataSource: _chartData,
            width: 0.3,
            spacing: 0,
            xValueMapper: (ExpenseData exp, _) => exp.year,
            yValueMapper: (ExpenseData exp, _) {
              switch (e) {
                case "Экспорт":
                  return exp.export;
                case "СНГ":
                  return exp.sng;
                case "Внутренний рынок":
                  return exp.innerMarket;
                case "Что-то":
                  return exp.smth;
                case "Внешний рынок":
                  return exp.out;
              }
            },
            color: getColorOfCol(e),
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.middle,
            ),
            name: e,
          ),
        ),
      ],
      primaryXAxis: CategoryAxis(),
    );
  }

  List<ExpenseData> getChartData() {
    final List<ExpenseData> chartData = [
      ...widget.data!.map(
        (e) => ExpenseData(e[0], double.parse(e[1]), double.parse(e[2]),
            double.parse(e[3]), double.parse(e[4]), double.parse(e[5])),
      )

      // ExpenseData("Tr3ansport", 34, 5, 21),
      // ExpenseData("Other2s", 35, 13, 34),
      // ExpenseData("Food1", 55, 4, 45),
      // ExpenseData("Transport1", 34, 5, 21),
      // ExpenseData("Others1", 35, 13, 34),
      // ExpenseData("Fo2od1", 55, 4, 45),
      // ExpenseData("Transp1ort", 34, 5, 21),
      // ExpenseData("O1thers", 35, 13, 34),
      // ExpenseData("F1ood", 55, 4, 45),
    ];
    return chartData;
  }
}

class ExpenseData {
  String year;
  num export = 0;
  num sng = 0;
  num innerMarket = 0;
  num smth = 0;
  num out = 0;
  ExpenseData(
    this.year,
    this.export,
    this.sng,
    this.innerMarket,
    this.smth,
    this.out,
  );
}
