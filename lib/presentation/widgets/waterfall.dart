/// Package imports
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/colors.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

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

  List<List<String>> getData() {
    List<List<String>> res = [];
    for (int i = 0; i < widget.value[widget.chosenIndex].length; i++) {
      widget.value[widget.chosenIndex][i] != "None"
          ? res.add([widget.labels[i], widget.value[widget.chosenIndex][i]])
          : res.add([widget.labels[i]]);
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
                    MaterialStatePropertyAll(ThemeColors().secondary)),
            onPressed: () {
              setState(
                () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: SizedBox(
                          width: 400,
                          height: 500,
                          child: Stack(
                            children: [
                              StatefulBuilder(
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
      zoomPanBehavior: ZoomPanBehavior(enablePinching: true),
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: widget.name),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        minimum: getMin(widget.data),
        maximum: (getMax(widget.data) * 1.2).ceil().toDouble(),
        interval: (getMax(widget.data) * 1.2).ceil().toDouble() / 5,
        // ((getMax(widget.data) * 1.2).ceil().toDouble() -
        //         getMin(widget.data)) /
        //     5,
        axisLine: const AxisLine(
          width: 0,
        ),
        majorTickLines: const MajorTickLines(size: 0),
      ),
      series: _getWaterFallSeries(),
      tooltipBehavior: _tooltipBehavior,
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

// child: Stack(
//   children: [
//     StatefulBuilder(
//       builder: (context, setState) {
//         return ListView.builder(
//           itemCount: widget.names!.length,
//           itemBuilder: (context, index) {
//             bool a = index == widget.chosenIndex;
//             return StatefulBuilder(
//                 builder: (context, setState) {
//               return CheckboxListTile(
//                 value: a,
//                 title: Text(widget.names![index]),
//                 onChanged: (newBool) {
//                   setState(() {
//                     widget.chosenIndex = index;
//                     a = newBool!;
//                   });
//                 },
//               );
//             });
//           },
//         );
//       },
//     ),
//     Align(
//       alignment: Alignment.bottomRight,
//       child: TextButton(
//         child: Text("OK"),
//         onPressed: () {
//           setState(() {});
//           Navigator.pop(context);
//         },
//       ),
//     )
//   ],
// ),
