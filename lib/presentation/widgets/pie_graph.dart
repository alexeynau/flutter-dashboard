import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/colors.dart';

class PieGraph extends StatefulWidget {
  List<List<String>> data;
  PieGraph({required this.data, super.key});

  @override
  State<PieGraph> createState() => _PieGraphState();
}

Color getColor(int i) {
  switch (i) {
    case 1:
      return ThemeColors().firstgradSec;
    case 2:
      return ThemeColors().firstgrad3;
    case 3:
      return ThemeColors().firstgrad4;
    case 4:
      return ThemeColors().firstgrad5;
    case 5:
      return ThemeColors().firstgrad6;
    case 6:
      return ThemeColors().firstgrad7;
    case 7:
      return ThemeColors().firstgrad8;
    case 8:
      return ThemeColors().firstgrad9;
    case 9:
      return ThemeColors().firstgrad10;
  }
  return ThemeColors().firstgrad;
}

class _PieGraphState extends State<PieGraph> {
  @override
  Widget build(BuildContext context) {
    int ind = -1;
    return Container(
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 1,
          sectionsSpace: 2,
          borderData: FlBorderData(show: false),
          sections: [
            // ind = -1;
            ...widget.data.map((e) {
              ind += 1;
              double h = MediaQuery.of(context).size.height;
              double w = MediaQuery.of(context).size.width;
              return PieChartSectionData(
                radius: h >= w ? (w / 2) * 0.35 : (h / 2) * 0.35,
                value: double.parse(e[1]),
                color: getColor(ind),
              );
            })
          ],
        ),
      ),
    );
  }
}
