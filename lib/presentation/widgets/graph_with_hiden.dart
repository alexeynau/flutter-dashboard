import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../data/repositories/windows_repository.dart';
import '../colors.dart';
import '../../service_locator.dart';

class LineChartSampleHidden extends StatefulWidget {
  final List<String>? names;
  final List<String>? data;
  final List<List<String>>? hidden;
  final String? name;
  final String? nameX;
  final List<List<String>>? value;
  final List<bool>? isChosen;
  const LineChartSampleHidden(
      {this.name,
      this.data,
      this.value,
      this.names,
      this.isChosen,
      this.nameX,
      super.key,
      this.hidden});

  @override
  State<LineChartSampleHidden> createState() => _LineChartSampleHiddenState();
}

class _LineChartSampleHiddenState extends State<LineChartSampleHidden> {
  WindowsRepository repository = getIt.get<WindowsRepository>();
  @override
  void initState() {
    super.initState();
  }

  // List<bool> getChosen() {
  //   return List.filled(widget.value!.length, true);
  // }

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
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 45),
              child: Row(
                children: [
                  Text(
                    widget.name!,
                    style: TextStyle(
                      fontSize: 15,
                      color: ThemeColors().primarytext,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 15,
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
                                            bool isSelected =
                                                widget.isChosen![index];
                                            return StatefulBuilder(
                                                builder: (context, setState) {
                                              return CheckboxListTile(
                                                value: isSelected,
                                                title:
                                                    Text(widget.names![index]),
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
                        });
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
        Container(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 0,
              left: 0,
              top: 40,
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
      if (widget.isChosen![index++]) {
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
      if (widget.isChosen![index++]) {
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
      if (widget.isChosen![index++]) {
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
                        fontSize: 12,
                        fontWeight: FontWeight.bold);
                    final textStyle1 = TextStyle(
                      color: touchedSpot.bar.gradient?.colors.first ??
                          touchedSpot.bar.color ??
                          ThemeColors().tooltipBg,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
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
                      touchedSpot.barIndex == 0
                          ? "${widget.nameX} = ${widget.data![touchedSpot.spotIndex]}:\n\n"
                          : "",
                      textStyle2,
                      children: [
                        TextSpan(
                            text: "${widget.names![touchedSpot.barIndex]}",
                            style: textStyle1),
                        TextSpan(text: "\n", style: textStyle1),
                        widget.isChosen![widget.names!
                                .indexOf(widget.names![touchedSpot.barIndex])]
                            ? TextSpan(
                                text: null,
                                children: [
                                  ...widget.hidden![widget.names!.indexOf(
                                          widget.names![touchedSpot.barIndex])]
                                      .map(
                                    (element) {
                                      return TextSpan(
                                        text: element,
                                        style: textStyle,
                                        children: [
                                          TextSpan(
                                            text:
                                                "= ${repository.getSeriesByName(element)[touchedSpot.spotIndex]} \n",
                                            style: textStyle4,
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                ],
                              )
                            : TextSpan(),
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
          ? getMin() * 0.5
          : getMin() == 0
              ? -3
              : getMin() * 1.5,
      maxY: getMax() < 5 ? 5 : getMax() * 1.2,
      lineBarsData: getLineBarsData(),
    );
  }
}
