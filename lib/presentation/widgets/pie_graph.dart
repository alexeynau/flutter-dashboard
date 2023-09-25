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
    int ind2 = -1;
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (p0, p1) {},
                ),
                centerSpaceRadius: 1,
                sectionsSpace: 2,
                borderData: FlBorderData(show: false),
                sections: [
                  ...widget.data.map((e) {
                    ind += 1;
                    double h = MediaQuery.of(context).size.height;
                    double w = MediaQuery.of(context).size.width;
                    return PieChartSectionData(
                      titleStyle: TextStyle(
                        color: ThemeColors().pieTextColor,
                      ),
                      radius: h >= w ? (w / 2) * 0.35 : (h / 2) * 0.35,
                      value: double.parse(e[1]),
                      color: getColor(ind),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Container(
              child: Column(
                children: [
                  ...widget.data.map((e) {
                    ind2 += 1;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10, right: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: getColor(ind2), shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(e[0]),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
