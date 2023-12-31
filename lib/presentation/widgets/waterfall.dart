import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import '../colors.dart';

class WaterFall extends StatefulWidget {
  List<List<String>> data = [];
  List<String> labels;
  List<String> names;

  String selectedValue = "";
  List<List<String>> value;
  int chosenIndex = 0;
  String name;
  WaterFall({
    required this.names,
    required this.value,
    required this.labels,
    required this.name,
    super.key,
  });

  @override
  State<WaterFall> createState() => _WaterFallState();
}

class _WaterFallState extends State<WaterFall> {
  List<_ChartSampleData>? chartData;
  TooltipBehavior? _tooltipBehavior;
  String getNormString(String s) {
    String res = "", sub = "";
    int len = 0;
    for (int i = 0; i < s.length; i++) {
      while (i < s.length && s[i] != " ") {
        sub += s[i];
        i++;
        len++;
      }

      if (sub.length > 7) {
        res += sub;
        res += "\n";
        len = 0;
        sub = "";
      } else {
        if (i == s.length) {
          res += sub;
        } else {
          sub += " ";
          len++;
        }
      }
    }
    return res;
  }

  List<List<String>> getData() {
    List<List<String>> res = [];
    for (int i = 0; i < widget.value[widget.chosenIndex].length; i++) {
      widget.value[widget.chosenIndex][i] == "None"
          ? res.add([getNormString(widget.labels[i])])
          : res.add([
              getNormString(widget.labels[i]),
              widget.value[widget.chosenIndex][i]
            ]);
    }
    return res;
  }

  @override
  void initState() {
    widget.selectedValue = widget.names[0];
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.data = getData();
    return Stack(children: [
      _buildDefaultWaterfallChart(),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: const EdgeInsets.only(
            right: 15,
            top: 5,
          ),
          width: 30,
          height: 20,
          child: TextButton(
            style: ButtonStyle(
                overlayColor:
                    MaterialStatePropertyAll(ThemeColors().opacityColor)),
            onPressed: () {
              setState(
                () {
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
                                        ...widget.names.map(
                                          (e) => RadioListTile(
                                            title: Text(e),
                                            value: e,
                                            groupValue: widget.selectedValue,
                                            onChanged: (value) {
                                              setState1(() {
                                                widget.selectedValue = value!;
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
                                    backgroundColor: MaterialStatePropertyAll(
                                        ThemeColors().barColor),
                                  ),
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      widget.chosenIndex = widget.names
                                          .indexOf(widget.selectedValue);
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
              );
            },
            child: Icon(
              Icons.filter_alt_rounded,
              color: ThemeColors().primarytext,
            ),
          ),
        ),
      ),
    ]);
  }

  double getMin(List<List<String>> data) {
    double min = double.maxFinite;
    double sum = 0;
    data.forEach(
      (element) {
        element.length == 2 ? sum += double.parse(element[1]) : sum += 0;
        sum < min ? min = sum : min = min;
      },
    );
    return min > 0 ? 0 : min;
  }

  double getSum(List<List<String>> data) {
    double sum = 0;
    data.forEach(
      (element) {
        element.length == 2 ? sum += double.parse(element[1]) : sum += 0;
      },
    );
    return sum.ceil().toDouble();
  }

  double getMax(List<List<String>> data) {
    double max = 0;
    double sum = 0;
    data.forEach(
      (element) {
        element.length == 2 ? sum += double.parse(element[1]) : sum += 0;
        sum > max ? max = sum : max = max;
      },
    );
    return max;
  }

  SfCartesianChart _buildDefaultWaterfallChart() {
    double sum = 0;
    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(enablePinching: false),
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: widget.name),
      primaryXAxis: CategoryAxis(
        labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width < 1265
                ? MediaQuery.of(context).size.width > 960
                    ? 6
                    : 5
                : 8),
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        minimum: getMin(widget.data) * 1.2,
        maximum: (getMax(widget.data) * 1.2).ceil().toDouble(),
        interval: (getMax(widget.data) * 1.2 - getMin(widget.data) * 1.2)
                .ceil()
                .toDouble() /
            5,
        axisLine: const AxisLine(
          width: 0,
        ),
        majorTickLines: const MajorTickLines(size: 0),
      ),
      series: _getWaterFallSeries(),
      tooltipBehavior: _tooltipBehavior,
      onDataLabelRender: (dataLabelArgs) {
        dataLabelArgs.pointIndex == widget.data.length - 1
            ? dataLabelArgs.text = getSum(widget.data) < 1000
                ? "≈" + getSum(widget.data).toString()
                : "≈" + (getSum(widget.data) / 1000).toString() + "K"
            : dataLabelArgs.text = "";
      },
      // onDataLabelRender: (DataLabelRenderArgs dataLabelArgs) {
      //   dataLabelArgs.textStyle = TextStyle(
      //     fontSize: 13,
      //     color: dataLabelArgs.pointIndex == 0
      //         ? ThemeColors().zeroText
      //         : widget.data[dataLabelArgs.pointIndex!].length == 1
      //             ? ThemeColors().summaryText
      //             : widget.data[dataLabelArgs.pointIndex!][1].contains("-")
      //                 ? ThemeColors().deleteText
      //                 : ThemeColors().addText,
      //   );

      //   widget.data[dataLabelArgs.pointIndex!].length == 2
      //       ? sum += double.parse(widget.data[dataLabelArgs.pointIndex!][1])
      //       : sum += 0;
      //   widget.data[dataLabelArgs.pointIndex!].length == 2
      //       ? (widget.data[dataLabelArgs.pointIndex!][1].contains("-") ||
      //               widget.data[dataLabelArgs.pointIndex!][1] == "0" ||
      //               widget.data
      //                       .indexOf(widget.data[dataLabelArgs.pointIndex!]) ==
      //                   0)
      //           ? dataLabelArgs.text = widget.data[dataLabelArgs.pointIndex!][1]
      //           : dataLabelArgs.text =
      //               "+${widget.data[dataLabelArgs.pointIndex!][1]}"
      //       : dataLabelArgs.text = sum.toString();
      // },
    );
  }

  List<WaterfallSeries<_ChartSampleData, dynamic>> _getWaterFallSeries() {
    return <WaterfallSeries<_ChartSampleData, dynamic>>[
      WaterfallSeries<_ChartSampleData, dynamic>(
        width: 0.8,
        spacing: 0.0,
        dataSource: <_ChartSampleData>[
          ...widget.data.map((e) {
            return _ChartSampleData(
                x: e[0],
                y: e.length == 2 ? double.parse(e[1]) : null,
                intermediateSumPredicate: false,
                totalSumPredicate: e.length == 2 ? false : true);
          })
        ],
        xValueMapper: (_ChartSampleData sales, _) => sales.x,
        yValueMapper: (_ChartSampleData sales, _) => sales.y,
        intermediateSumPredicate: (_ChartSampleData sales, _) =>
            sales.intermediateSumPredicate,
        totalSumPredicate: (_ChartSampleData sales, _) =>
            sales.totalSumPredicate,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, labelAlignment: ChartDataLabelAlignment.middle),
        color: ThemeColors().add,
        negativePointsColor: ThemeColors().delete,
        totalSumColor: ThemeColors().summary,
      )
    ];
  }
}

class _ChartSampleData {
  _ChartSampleData(
      {this.x, this.y, this.intermediateSumPredicate, this.totalSumPredicate});

  final String? x;
  final num? y;
  final bool? intermediateSumPredicate;
  final bool? totalSumPredicate;
}
