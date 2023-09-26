import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
          padding: EdgeInsets.only(top: 50),
          child: BarChart(
            BarChartData(
              maxY: getMax() * 1.2,
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: false,
                )),
                rightTitles: AxisTitles(
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
                    x: _index++,
                    barRods: [
                      BarChartRodData(
                        borderRadius: BorderRadius.zero,
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
