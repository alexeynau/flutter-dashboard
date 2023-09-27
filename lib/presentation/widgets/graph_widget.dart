// ignore_for_file: prefer_const_constructors

// import 'dart:js_interop';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/domain/repositories/json_repository.dart';
import 'package:flutter_dashboard/presentation/colors.dart';
import 'package:flutter_dashboard/service_locator.dart';

class LineChartSample2 extends StatefulWidget {
  final List<String>? names;
  final List<String>? data;
  final List<List<String>>? hidden;
  final String? name;
  final List<List<String>>? value;
  final List<bool>? isChosen;
  const LineChartSample2(
      {this.name,
      this.data,
      this.value,
      this.names,
      this.isChosen,
      super.key,
      this.hidden});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<List<String>>? chosenSeries;

  @override
  void initState() {
    super.initState();
  }

  List<bool> getChosen() {
    return List.filled(widget.value!.length, true);
  }

  List<LineChartBarData> getLineBarsData() {
    List<LineChartBarData> data = [];
    int _currentIndex = 1;
    int _indexForElem = 0;
    widget.value!.forEach((element) {
      _indexForElem = -1;
      if (widget.isChosen![_currentIndex - 1]) {
        data.add(
          LineChartBarData(
            showingIndicators: [0],
            gradient: LinearGradient(
              colors: getGradColor(_currentIndex),
            ),
            barWidth: 3,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: false,
              gradient: LinearGradient(
                colors: getGradColor(_currentIndex)
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
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
      }
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
              left: 38,
              top: 75,
              bottom: 50,
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
              top: 23,
              bottom: 30,
            ),
            child: Column(
              children: [
                ...widget.value!.map((e) {
                  indexData += 1;
                  if (widget.isChosen![indexData]) {
                    return Text(
                      "${widget.names?[indexData] ?? ""}, сумма = ${getSum(e)}",
                      style: TextStyle(
                        fontSize: 14,
                        color: getColor(indexData),
                      ),
                    );
                  } else
                    return Container(
                      height: 0,
                      width: 0,
                    );
                }),
              ],
            ),
          ),
        ),
        Container(
          child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                widget.name!,
                style: TextStyle(fontSize: 20),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 25,
            right: 25,
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 60,
              height: 24,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: SizedBox(
                              width: 400,
                              height: 500,
                              child: Stack(
                                children: [
                                  ListView.builder(
                                    itemCount: widget.names!.length,
                                    itemBuilder: (context, index) {
                                      bool isSelected = widget.isChosen![index];
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return CheckboxListTile(
                                          value: isSelected,
                                          title: Text(widget.names![index]),
                                          onChanged: (newBool) {
                                            setState(() {
                                              widget.isChosen?[index] =
                                                  newBool!;
                                              isSelected = newBool!;
                                            });
                                          },
                                        );
                                      });
                                    },
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: TextButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        setState(() {});
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                ],
                              )),
                        );
                      },
                    );

                    // widget.isChosen = widget.isChosen;
                  });
                },
                child: Icon(
                  Icons.filter_alt_rounded,
                  color: ThemeColors().primarytext,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Color> getGradColor(int i) {
    switch (i) {
      case 2:
        return [ThemeColors().firstgradSec, ThemeColors().secondgradSec];
      case 3:
        return [ThemeColors().firstgrad3, ThemeColors().secondgrad3];
      case 4:
        return [ThemeColors().firstgrad4, ThemeColors().secondgrad4];
      case 5:
        return [ThemeColors().firstgrad5, ThemeColors().secondgrad5];
      case 6:
        return [ThemeColors().firstgrad6, ThemeColors().secondgrad6];
      case 7:
        return [ThemeColors().firstgrad7, ThemeColors().secondgrad7];
      case 8:
        return [ThemeColors().firstgrad8, ThemeColors().secondgrad8];
      case 9:
        return [ThemeColors().firstgrad9, ThemeColors().secondgrad9];
      case 10:
        return [ThemeColors().firstgrad10, ThemeColors().secondgrad10];
    }
    return [ThemeColors().firstgrad, ThemeColors().secondgrad];
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

  double getSum(List<String> str) {
    double sum = 0;
    str.forEach((e) {
      double a = double.parse(e);
      sum += a;
    });
    return sum.toInt().toDouble();
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
    double min = double.maxFinite;
    int index = 0;
    widget.value!.forEach((element) {
      if (widget.isChosen![index++]) {
        element.forEach((e) {
          double a = double.parse(e);
          a < min ? min = a : min = min;
        });
      }
    });

    return min < 0 ? min : 0;
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
        touchSpotThreshold: 20,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: ThemeColors().tooltipBg,
          getTooltipItems: (touchedSpots) {
            {
              if (widget.hidden == null || widget.hidden!.isEmpty) {
                return touchedSpots.map((LineBarSpot touchedSpot) {
                  final textStyle = TextStyle(
                    color: touchedSpot.bar.gradient?.colors.first ??
                        touchedSpot.bar.color ??
                        ThemeColors().tooltipBg,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  return LineTooltipItem(
                    "${getMonth(touchedSpot.x)} = ${touchedSpot.y}",
                    textStyle,
                  );
                }).toList();
              } else {
                List<LineTooltipItem> items = [];
                var repository = getIt<JsonRepository>();
                touchedSpots.forEach((touchedSpot) {
                  String params = "";
                  final textStyle = TextStyle(
                    color: touchedSpot.bar.gradient?.colors.first ??
                        touchedSpot.bar.color ??
                        ThemeColors().tooltipBg,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  );
                  (widget.hidden?[touchedSpot.barIndex] ?? [])
                      .forEach((hiddenParam) {
                    params +=
                        "$hiddenParam: ${repository.getSeriesByName(hiddenParam)[touchedSpot.spotIndex]}\n";
                  });
                  items.add(LineTooltipItem(params, textStyle));
                });
                //  return LineTooltipItem(
                //   "${getMonth(touchedSpot.x)} = ${touchedSpot.y}",
                //   textStyle,
                // );
                return items;
              }
            }
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return (value == 0)
              ? FlLine(
                  color: Colors.black,
                  strokeWidth: 3,
                )
              : FlLine(
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
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return Transform.rotate(
                  angle: pi / 12.0,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.data![value.ceil()]),
                  ),
                );
              }

              // getTitlesWidget: bottomTitleWidgets,
              ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: (getMax() - getMin()) / 10,
            // getTitlesWidget: leftTitleWidgets,
            reservedSize: 52,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: ThemeColors().maingridbordercolor),
      ),
      minX: 0,
      maxX: widget.data!.length.toDouble() - 1,
      minY: getMin() * 1.3,
      maxY: getMax() * 1.2,
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