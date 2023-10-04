// ignore_for_file: prefer_const_constructors

// import 'dart:js_interop';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/domain/repositories/json_repository.dart';
import 'package:flutter_dashboard/presentation/colors.dart';
import 'package:flutter_dashboard/service_locator.dart';
import 'package:http/http.dart';

class LineChartSample2 extends StatefulWidget {
  final List<String>? names;
  String selectedValue = "";
  int chosenIndex = 0;
  final List<String>? data;
  final String? name;
  final List<List<String>>? value;
  final List<bool>? isChosen;
  LineChartSample2({
    this.name,
    this.data,
    this.value,
    this.names,
    this.isChosen,
    super.key,
  });

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<List<String>>? chosenSeries;

  @override
  void initState() {
    widget.selectedValue = widget.names![0];
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
      if (widget.chosenIndex == _currentIndex - 1) {
        data.add(
          LineChartBarData(
            showingIndicators: [0],
            color: getGradColor(_currentIndex).first,
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (p0, p1, p2, p3) {
                return FlDotCirclePainter(
                  radius: 0,
                  color: p2.color!,
                  strokeColor: p2.color!,
                );
              },
            ),
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

  double getChosenLen() {
    double len = 0;
    widget.isChosen!.forEach((element) {
      element ? len++ : len = len;
    });
    return len;
  }

  @override
  Widget build(BuildContext context) {
    int currentDot = 0;

    return Stack(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              flex: 10,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.only(top: 10, left: 50),
                  child: Text(
                    widget.name!,
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width < 1000 ? 10 : 13,
                      color: ThemeColors().primarytext,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(
                    top: 18,
                    right: 0,
                  ),
                  width: 30,
                  height: 20,
                  color: ThemeColors().opacityColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 5, right: 5),
                                    width: 400,
                                    height: 500,
                                    child: Stack(
                                      children: [
                                        SingleChildScrollView(
                                          child: StatefulBuilder(
                                            builder: (context, setState1) {
                                              return Column(
                                                children: [
                                                  ...widget.names!.map(
                                                    (e) => RadioListTile(
                                                      title: Text(e),
                                                      value: e,
                                                      groupValue:
                                                          widget.selectedValue,
                                                      onChanged: (value) {
                                                        setState1(() {
                                                          widget.selectedValue =
                                                              value!;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.bottomRight,
                                          padding: const EdgeInsets.only(
                                              bottom: 15, right: 15),
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      ThemeColors().barColor),
                                            ),
                                            child: const Text(
                                              "OK",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                widget.chosenIndex =
                                                    widget.names!.indexOf(
                                                        widget.selectedValue);
                                              });
                                              Navigator.pop(context);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.filter_alt_rounded,
                            color: ThemeColors().primarytext,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          child: Container(
            padding: EdgeInsets.only(
              right: 0,
              left: 0,
              top: 48,
              bottom: 20,
            ),
            child: LineChart(
              mainData(),
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
    double max = 2;
    int index = 0;
    widget.value!.forEach((element) {
      if (widget.chosenIndex == widget.value!.indexOf(element)) {
        element.forEach((e) {
          double a = double.parse(e);
          a > max ? max = a : max = max;
        });
      }
    });

    return max;
  }

  double getRealMin() {
    double min = double.maxFinite;
    int index = 0;
    widget.value!.forEach((element) {
      if (widget.chosenIndex == widget.value!.indexOf(element)) {
        element.forEach((e) {
          double a = double.parse(e);
          a < min ? min = a : min = min;
        });
      }
    });

    return min;
  }

  double getMin() {
    double min = double.maxFinite;
    int index = 0;
    widget.value!.forEach((element) {
      if (widget.chosenIndex == widget.value!.indexOf(element)) {
        element.forEach((e) {
          double a = double.parse(e);
          a < min ? min = a : min = min;
        });
      }
    });

    return min;
  }

  String getMonth(double x) {
    String s = "";
    return widget.data![x.toInt()];
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        handleBuiltInTouches: true,
        touchSpotThreshold: 30,
        touchTooltipData: LineTouchTooltipData(
          tooltipHorizontalOffset: -MediaQuery.of(context).size.width,
          tooltipHorizontalAlignment: FLHorizontalAlignment.left,
          showOnTopOfTheChartBoxArea: true,
          tooltipBgColor: ThemeColors().tooltipBgWithOp,
          fitInsideVertically: true,
          maxContentWidth: 200,
          fitInsideHorizontally: true,
          getTooltipItems: (touchedSpots) {
            {
              List<LineTooltipItem> itemsTooltip = [
                ...touchedSpots.map(
                  (LineBarSpot touchedSpot) {
                    final textStyle = TextStyle(
                      color: touchedSpot.bar.gradient?.colors.first ??
                          touchedSpot.bar.color ??
                          ThemeColors().tooltipBg,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    );

                    final textStyle2 = TextStyle(
                        color: ThemeColors().primarytext,
                        fontSize: 12,
                        fontWeight: FontWeight.bold);
                    final textStyle4 = TextStyle(
                        color: ThemeColors().primarytext,
                        fontSize: 12,
                        fontWeight: FontWeight.normal);

                    return LineTooltipItem(
                      "${widget.data![touchedSpot.spotIndex]}:\n",
                      textStyle2,
                      children: [
                        TextSpan(
                          style: TextStyle(
                              color: touchedSpot.bar.gradient?.colors.first ??
                                  touchedSpot.bar.color ??
                                  ThemeColors().tooltipBg,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          text: "${widget.names![touchedSpot.barIndex]}",
                        ),
                        TextSpan(
                          text: "= ${touchedSpot.y}",
                          style: textStyle4,
                        ),
                      ],
                    );
                  },
                )
              ];

              List<LineTooltipItem> items = [];
              widget.names!.forEach((element) {
                itemsTooltip!.forEach((e) {
                  e.children![0].text == element ? items.add(e) : "";
                });
              });
              return items;
            }
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          if (value > (getMax() - 4 / 5 * (getMax() - getMin())) &&
              value < (getMax() - 1 / 5 * (getMax() - getMin()))) {
            return FlLine(
              color: Colors.black,
              strokeWidth: 2,
            );
          }
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
              showTitles: true,
              reservedSize: 30,
              interval: widget.data!.length / 3,
              getTitlesWidget: (value, meta) {
                return Transform.rotate(
                  angle: pi / 10,
                  child: Container(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      value != widget.data!.length.toDouble() - 1
                          ? widget.data![value.ceil()]
                          : "",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                );
              }),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 52,
              getTitlesWidget: (value, meta) {
                return Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    (value > (getMax() - 4 / 5 * (getMax() - getMin())) &&
                            value < (getMax() - 1 / 5 * (getMax() - getMin())))
                        ? meta.formattedValue
                        : "",
                    style: TextStyle(fontSize: 10),
                  ),
                );
              }),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: ThemeColors().maingridbordercolor),
      ),
      minX: 0,
      maxX: widget.data!.length.toDouble() - 1,
      minY: getMin() > 0
          ? getMin() * 0.7
          : getMin() == 0
              ? -3
              : getMin() * 1.3,
      maxY: getMax() < 5 ? 5 : getMax() * 1.2,
      lineBarsData: getLineBarsData(),
    );
  }
}
