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
          padding: const EdgeInsets.only(top: 50),
          child: BarChart(
            BarChartData(
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: ThemeColors().tooltipBg,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      rod.toY.round().toString(),
                      TextStyle(
                        color: ThemeColors().primarytext,
                      ),
                    );
                  },
                ),
              ),
              maxY: getMax() * 1.2,
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
                      return Text(widget.data[value.ceil()]);
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
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        width: 40,
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
}
