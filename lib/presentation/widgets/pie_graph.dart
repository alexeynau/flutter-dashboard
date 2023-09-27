import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/colors.dart';

class PieGraph extends StatefulWidget {
  List<List<String>> data;
  String? name;
  PieGraph({required this.data, this.name, super.key});

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

Color getColorCircle(int i) {
  switch (i) {
    case 1:
      return ThemeColors().pieBg2;
    case 2:
      return ThemeColors().pieBg3;
    case 3:
      return ThemeColors().pieBg4;
    case 4:
      return ThemeColors().pieBg5;
    case 5:
      return ThemeColors().pieBg6;
    case 6:
      return ThemeColors().pieBg7;
    case 7:
      return ThemeColors().pieBg8;
    case 8:
      return ThemeColors().pieBg9;
    case 9:
      return ThemeColors().pieBg10;
  }
  return ThemeColors().pieBg1;
}

class _PieGraphState extends State<PieGraph> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    int ind = -1;
    int ind2 = -1;

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: Container(
            child: Column(
              children: [
                if (widget.name != null)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        widget.name!,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                Expanded(
                  flex: 10,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      centerSpaceRadius:
                          h >= w ? (w / 2) * 0.17 : (h / 2) * 0.17,
                      sectionsSpace: 2,
                      borderData: FlBorderData(show: false),
                      sections: [
                        ...widget.data.map((e) {
                          bool isTouched =
                              widget.data.indexOf(e) == touchedIndex;
                          ind += 1;

                          return PieChartSectionData(
                            titleStyle: TextStyle(
                              color: ThemeColors().pieTextColor,
                              fontSize: isTouched ? 20 : 15,
                            ),
                            radius: isTouched
                                ? h >= w
                                    ? (w / 2) * 0.22
                                    : (h / 2) * 0.22
                                : h >= w
                                    ? (w / 2) * 0.15
                                    : (h / 2) * 0.15,
                            value: double.parse(e[1]),
                            color: getColorCircle(ind),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Column(
              children: [
                ...widget.data.map(
                  (e) {
                    ind2 += 1;
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 15,
                        left: 15,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                color: getColorCircle(ind2),
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            e[0],
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
