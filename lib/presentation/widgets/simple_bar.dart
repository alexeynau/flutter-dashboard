import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class SimpleBar extends StatefulWidget {
  const SimpleBar({
    super.key,
    this.names,
    required this.data,
    this.hidden,
    required this.name,
    required this.value,
    required this.isChosen,
  });

  final List<String>? names;
  final List<String> data; //xs
  final List<List<String>>? hidden;
  final String name;
  final List<List<String>> value; //ys
  final List<bool> isChosen;
  @override
  State<SimpleBar> createState() => _SimpleBarState();
}

class _SimpleBarState extends State<SimpleBar> {
  String getTwoAfterDot(String a) {
    String s = "";
    int i = 0;
    while (i < a.length && a[i] != ".") {
      s += a[i];
      i++;
    }
    // print(s);
    if (i == a.length - 1) {
      return s;
    }

    if (a[i + 1] != "0") {
      s += a[i];
      i++;

      s += a[i];
      if (i == a.length - 1) {
        return s;
      }
      i++;
      s += a[i];

      return s;
    }
    return s;
  }

  // if (dou
  // t = double.parse(a[i + 2]) + 1;

  //   s += a[i + 2];
  // }

  @override
  Widget build(BuildContext context) {
    var _index = 0;
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text(widget.name),
        ),
        Container(
          padding: const EdgeInsets.only(top: 50, bottom: 20),
          child: BarChart(
            BarChartData(
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: ThemeColors().opacityColor,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      getTwoAfterDot(rod.toY.toString()),
                      TextStyle(color: ThemeColors().primarytext, fontSize: 10),
                    );
                  },
                ),
              ),
              maxY: getMax() * 1.2,
              minY: getMin() < 0 ? getMin() * 1.2 : 0,
              gridData: const FlGridData(
                drawVerticalLine: false,
                show: false,
              ),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: false,
                )),
                rightTitles: const AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: false,
                )),
                leftTitles: const AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: false,
                )),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Transform.rotate(
                        angle: pi / 12,
                        child: Text(
                          widget.data[value.ceil()],
                          style: TextStyle(fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: [
                ...widget.data.map((e) {
                  return BarChartGroupData(
                    showingTooltipIndicators: [0],
                    x: _index++,
                    barRods: [
                      BarChartRodData(
                        color: ThemeColors().barColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(3),
                            topRight: Radius.circular(3)),
                        width: 30,
                        toY: double.parse(
                          widget.value[widget.isChosen.indexOf(true)]
                              [_index - 1],
                        ),
                      )
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  double getMax() {
    double max = 0;
    int index = 0;
    widget.value!.forEach((element) {
      if (widget.isChosen![index++]) {
        element.forEach((e) {
          double a = double.parse(e);
          a > max ? max = a : max = max;
        });
      }
    });

    return max;
  }

  double getMin() {
    double min = 0;
    int index = 0;
    widget.value!.forEach((element) {
      if (widget.isChosen![index++]) {
        element.forEach((e) {
          double a = double.parse(e);
          a < min ? min = a : min = min;
        });
      }
    });

    return min;
  }
}
