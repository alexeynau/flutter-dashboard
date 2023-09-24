import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnChart extends StatefulWidget {
  List<List<String>>? data;
  ColumnChart({this.data, super.key});

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

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: "Распределение по рынкам"),
      legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      series: <ChartSeries>[
        StackedColumn100Series<ExpenseData, String>(
          dataSource: _chartData,
          width: 0.3,
          spacing: 0,
          xValueMapper: (ExpenseData exp, _) => exp.year,
          yValueMapper: (ExpenseData exp, _) => exp.export,
          color: ThemeColors().export,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.middle,
          ),
          name: "Экспорт",
        ),
        StackedColumn100Series<ExpenseData, String>(
          dataSource: _chartData,
          width: 0.3,
          spacing: 0,
          xValueMapper: (ExpenseData exp, _) => exp.year,
          yValueMapper: (ExpenseData exp, _) => exp.sng,
          color: ThemeColors().sng,
          // dataLabelSettings: const DataLabelSettings(
          //   isVisible: true,
          //   labelAlignment: ChartDataLabelAlignment.middle,
          // ),
          name: "СНГ",
        ),
        StackedColumn100Series<ExpenseData, String>(
          dataSource: _chartData,
          width: 0.3,
          spacing: 0,
          xValueMapper: (ExpenseData exp, _) => exp.year,
          yValueMapper: (ExpenseData exp, _) => exp.innerMarket,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.middle,
          ),
          color: ThemeColors().innerMarket,
          name: "Внутренный рынок",
        ),
      ],
      primaryXAxis: CategoryAxis(),
    );
  }

  List<ExpenseData> getChartData() {
    final List<ExpenseData> chartData = [
      ...widget.data!.map(
        (e) => ExpenseData(
            e[0], double.parse(e[1]), double.parse(e[2]), double.parse(e[3])),
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
  final String year;
  final num export;
  final num sng;
  final num innerMarket;
  final num test = 0;
  ExpenseData(
    this.year,
    this.export,
    this.sng,
    this.innerMarket,
  );
}
