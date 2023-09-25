import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/colors.dart';

class BarGraph extends StatefulWidget {
  String name;
  List<String>? month;
  BarGraph({required this.name, required this.month, super.key});

  @override
  State<BarGraph> createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {
  List<double> getMonthlyValue() {
    List<double> res = [];
    widget.month!.forEach((element) {
      res.add(double.parse(element));
    });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    List<double> monthlyValue = getMonthlyValue();
    // List<double> monthlyValue = [
    //   12.4,
    //   15.6,
    //   48.4,
    //   89.1,
    //   30.0,
    //   11.1,
    //   45.1,
    //   11.6,
    //   42.0,
    //   49.5,
    //   37.3,
    //   26.1,
    // ];

    double getMax(List<double> m) {
      double max = 0;
      m.forEach((e) {
        e > max ? max = e : max = max;
      });
      return max;
    }

    BarData barData = BarData(
      janValue: monthlyValue[0],
      febValue: monthlyValue[1],
      marValue: monthlyValue[2],
      aprValue: monthlyValue[3],
      mayValue: monthlyValue[4],
      junValue: monthlyValue[5],
      julValue: monthlyValue[6],
      augValue: monthlyValue[7],
      sepValue: monthlyValue[8],
      octValue: monthlyValue[9],
      novValue: monthlyValue[10],
      decValue: monthlyValue[11],
    );
    barData.initializeBarData(monthlyValue);
    return Padding(
      padding: const EdgeInsets.only(
        left: 0,
        bottom: 15,
      ),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Text(
                widget.name,
                style:
                    TextStyle(fontSize: 16, color: ThemeColors().primarytext),
              )),
          BarChart(
            BarChartData(
              barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: ThemeColors().tooltipBg)),
              rangeAnnotations: RangeAnnotations(),
              maxY: getMax(monthlyValue) * 1.4,
              minY: 0,
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: const FlTitlesData(
                show: true,
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: getBottomTitles,
                )),
              ),
              barGroups: barData.barData
                  .map((e) => BarChartGroupData(x: e.x, barRods: [
                        BarChartRodData(
                          toY: e.y,
                          color: ThemeColors().barColor,
                          width: 25,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ]))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class Bar {
  final int x;
  final double y;
  Bar({
    required this.x,
    required this.y,
  });
}

class BarData {
  final double janValue;
  final double febValue;
  final double marValue;
  final double aprValue;
  final double mayValue;
  final double junValue;
  final double julValue;
  final double augValue;
  final double sepValue;
  final double octValue;
  final double novValue;
  final double decValue;

  BarData({
    required this.janValue,
    required this.febValue,
    required this.marValue,
    required this.aprValue,
    required this.mayValue,
    required this.junValue,
    required this.julValue,
    required this.augValue,
    required this.sepValue,
    required this.octValue,
    required this.novValue,
    required this.decValue,
  });

  List<Bar> barData = [];

  void initializeBarData(List<double> monthValue) {
    int i = -1;
    barData = [
      ...monthValue.map((e) {
        i += 1;
        return Bar(x: i, y: e);
      })
    ];
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  TextStyle style = TextStyle(
    color: ThemeColors().primarytext,
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );
  Widget text;

  switch (value.toInt()) {
    case 0:
      text = Text(
        "Jan",
        style: style,
      );
      break;
    case 1:
      text = Text(
        "Feb",
        style: style,
      );
      break;
    case 2:
      text = Text(
        "Mar",
        style: style,
      );
      break;
    case 3:
      text = Text(
        "Apr",
        style: style,
      );
      break;
    case 4:
      text = Text(
        "May",
        style: style,
      );
      break;
    case 5:
      text = Text(
        "Jun",
        style: style,
      );
      break;
    case 6:
      text = Text(
        "Jul",
        style: style,
      );
      break;
    case 7:
      text = Text(
        "Aug",
        style: style,
      );
      break;
    case 8:
      text = Text(
        "Sep",
        style: style,
      );
      break;
    case 9:
      text = Text(
        "Oct",
        style: style,
      );
      break;
    case 10:
      text = Text(
        "Nov",
        style: style,
      );
      break;
    case 11:
      text = Text(
        "Dec",
        style: style,
      );
      break;
    default:
      text = Text(
        "",
        style: style,
      );
      break;
  }

  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
