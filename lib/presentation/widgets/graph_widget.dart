// ignore_for_file: prefer_const_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/colors.dart';

class LineChartSample2 extends StatefulWidget {
  List<String>? data;
  List<List<String>>? value;
  LineChartSample2({this.data, this.value, super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

List<Color> gradientColors = [
  ThemeColors().firstgrad,
  ThemeColors().secondgrad,
];

List<Color> gradientColorsSec = [
  ThemeColors().firstgradSec,
  ThemeColors().secondgradSec,
];
@override
void initState() {}

class _LineChartSample2State extends State<LineChartSample2> {
  List<LineChartBarData> getLineBarsData() {
    List<LineChartBarData> data = [];
    int _currentIndex = 1;
    int _indexForElem = 0;
    widget.value!.forEach((element) {
      _indexForElem = -1;
      data.add(
        LineChartBarData(
          gradient: LinearGradient(
            colors: _currentIndex == 1 ? gradientColors : gradientColorsSec,
          ),
          barWidth: 3,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
                colors: _currentIndex == 1
                    ? gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList()
                    : gradientColorsSec
                        .map((color) => color.withOpacity(0.3))
                        .toList()),
          ),
          spots: [
            ...element.map((e) {
              _indexForElem += 1;
              return FlSpot(
                _indexForElem.toDouble(),
                double.parse(element[_indexForElem]),
              );
            }).toList(),
          ],
        ),
      );
      _currentIndex += 1;
    });

    return data;
  }

  @override
  Widget build(BuildContext context) {
    int indexData = -1;
    return Stack(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 40,
              left: 20,
              top: 20,
              bottom: 30,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 20,
              left: 40,
              top: 20,
              bottom: 30,
            ),
            child: Column(
              children: [
                ...widget.value!.map((e) {
                  indexData += 1;
                  return Text(
                    getSum(e).toString(),
                    style: TextStyle(
                        fontSize: 20,
                        color: indexData == 0
                            ? ThemeColors().firstgrad
                            : ThemeColors().firstgradSec),
                  );
                }),
              ],
            ),
          ),
        )
      ],
    );
  }

  double getSum(List<String> str) {
    double sum = 0;
    str.forEach((e) {
      double a = double.parse(e);
      sum += a;
    });
    return sum;
  }

  double getMax() {
    double max = 0;
    widget.value!.forEach((element) {
      element.forEach((e) {
        double a = double.parse(e);
        a > max ? max = a : max = max;
      });
    });
    return max;
  }

  // Widget leftTitleWidgets(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     fontWeight: FontWeight.bold,
  //     fontSize: 15,
  //   );
  //   String text;
  //   if (value.toInt() % 2 == 1)
  //     text = (value.toInt() * 10).toString() + "K";
  //   else
  //     return Container();

  //   return Text(text, style: style, textAlign: TextAlign.left);
  // }

  String getMonth(double x) {
    String s = "";
    return widget.data![x.toInt()];
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: ThemeColors().tooltipBg,
          getTooltipItems: (touchedSpots) {
            {
              return touchedSpots.map((LineBarSpot touchedSpot) {
                final textStyle = TextStyle(
                  color: touchedSpot.bar.gradient?.colors.first ??
                      touchedSpot.bar.color ??
                      ThemeColors().tooltipBg,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                );
                return LineTooltipItem(
                  getMonth(touchedSpot.x) + " " + touchedSpot.y.toString(),
                  textStyle,
                );
              }).toList();
            }
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: ThemeColors().maingridcolor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: ThemeColors().maingridcolor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
            interval: 1,
            // getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            // getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: ThemeColors().maingridbordercolor),
      ),
      minX: 0,
      maxX: widget.data!.length.toDouble() - 1,
      minY: 0,
      maxY: getMax() + getMax(),
      lineBarsData: getLineBarsData(),
    );
  }
}













// LineChartBarData(
//           spots: const [
//             FlSpot(1, 3),
//             FlSpot(2, 4),
//             FlSpot(3, 2),
//             FlSpot(4, 6),
//             FlSpot(5, 8),
//             FlSpot(6, 1),
//             FlSpot(7, 3.1),
//             FlSpot(8, 7),
//             FlSpot(9, 4),
//             FlSpot(10, 3),
//             FlSpot(11, 3),
//             FlSpot(12, 4),
//           ],
//           gradient: LinearGradient(
//             colors: gradientColors,
//           ),
//           barWidth: 3,
//           isStrokeCapRound: true,
//           dotData: const FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: gradientColors
//                   .map((color) => color.withOpacity(0.3))
//                   .toList(),
//             ),
//           ),
//         ),





  // LineChartBarData get lineChartBarData1 => LineChartBarData(
  //       gradient: LinearGradient(
  //         colors: gradientColors,
  //       ),
  //       barWidth: 3,
  //       dotData: FlDotData(show: false),
  //       belowBarData: BarAreaData(
  //         show: true,
  //         gradient: LinearGradient(
  //           colors:
  //               gradientColors.map((color) => color.withOpacity(0.3)).toList(),
  //         ),
  //       ),
  //       spots: const [
  //         FlSpot(1, 3),
  //         FlSpot(2, 4),
  //         FlSpot(3, 2),
  //         FlSpot(4, 6),
  //         FlSpot(5, 8),
  //         FlSpot(6, 1),
  //         FlSpot(7, 3.1),
  //         FlSpot(8, 7),
  //         FlSpot(9, 4),
  //         FlSpot(10, 3),
  //         FlSpot(11, 3),
  //         FlSpot(12, 4),
  //       ],
  //     );

  // LineChartBarData get lineChartBarData2 => LineChartBarData(
  //       gradient: LinearGradient(
  //         colors: gradientColorsSec,
  //       ),
  //       barWidth: 3,
  //       dotData: FlDotData(show: false),
  //       belowBarData: BarAreaData(
  //         show: true,
  //         gradient: LinearGradient(
  //           colors: gradientColorsSec
  //               .map((color) => color.withOpacity(0.3))
  //               .toList(),
  //         ),
  //       ),
  //       spots: const [
  //         FlSpot(1, 7),
  //         FlSpot(2, 9),
  //         FlSpot(3, 4),
  //         FlSpot(4, 2),
  //         FlSpot(5, 7),
  //         FlSpot(6, 4),
  //         FlSpot(7, 6.1),
  //         FlSpot(8, 4.2),
  //         FlSpot(9, 3),
  //         FlSpot(10, 8),
  //         FlSpot(11, 1),
  //         FlSpot(12, 5),
  //       ],
  //     );


  // Widget bottomTitleWidgets(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     fontWeight: FontWeight.bold,
  //     fontSize: 10,
  //   );
  //   Widget text;
  //   switch (value.toInt()) {
  //     case 1:
  //       text = const Text('JAN', style: style);
  //       break;
  //     case 2:
  //       text = const Text('FEB', style: style);
  //       break;
  //     case 3:
  //       text = const Text('MAR', style: style);
  //       break;
  //     case 4:
  //       text = const Text('APR', style: style);
  //       break;
  //     case 5:
  //       text = const Text('MAY', style: style);
  //       break;
  //     case 6:
  //       text = const Text('JUN', style: style);
  //       break;
  //     case 7:
  //       text = const Text('JUL', style: style);
  //       break;
  //     case 8:
  //       text = const Text('AUG', style: style);
  //       break;
  //     case 9:
  //       text = const Text('SEP', style: style);
  //       break;
  //     case 10:
  //       text = const Text('OCT', style: style);
  //       break;
  //     case 11:
  //       text = const Text('NOV', style: style);
  //       break;
  //     case 12:
  //       text = const Text('DEC', style: style);
  //       break;
  //     default:
  //       text = const Text('', style: style);
  //       break;
  //   }

  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     child: text,
  //   );
  // }