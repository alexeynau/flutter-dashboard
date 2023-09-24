import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ColumnChart extends StatefulWidget {
  const ColumnChart({super.key});

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
          xValueMapper: (ExpenseData exp, _) => exp.year,
          yValueMapper: (ExpenseData exp, _) => exp.export,
          color: ThemeColors().export,
          name: "Экспорт",
        ),
        StackedColumn100Series<ExpenseData, String>(
          dataSource: _chartData,
          xValueMapper: (ExpenseData exp, _) => exp.year,
          yValueMapper: (ExpenseData exp, _) => exp.sng,
          color: ThemeColors().sng,
          name: "СНГ",
        ),
        StackedColumn100Series<ExpenseData, String>(
          dataSource: _chartData,
          xValueMapper: (ExpenseData exp, _) => exp.year,
          yValueMapper: (ExpenseData exp, _) => exp.innerMarket,
          color: ThemeColors().innerMarket,
          name: "Внутренный рынок",
        ),
      ],
      primaryXAxis: CategoryAxis(),
    );
  }

  List<ExpenseData> getChartData() {
    final List<ExpenseData> chartData = [
      ExpenseData("F1oo4d", 55, 4, 45),
      ExpenseData("Tr3ansport", 34, 5, 21),
      ExpenseData("Other2s", 35, 13, 34),
      ExpenseData("Food1", 55, 4, 45),
      ExpenseData("Transport1", 34, 5, 21),
      ExpenseData("Others1", 35, 13, 34),
      ExpenseData("Fo2od1", 55, 4, 45),
      ExpenseData("Transp1ort", 34, 5, 21),
      ExpenseData("O1thers", 35, 13, 34),
      ExpenseData("F1ood", 55, 4, 45),
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
