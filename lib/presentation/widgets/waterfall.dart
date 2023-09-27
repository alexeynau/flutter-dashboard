/// Package imports
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/colors.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

class WaterFall extends StatefulWidget {
  List<List<String>> data = [];
  // List<String> labels;
  // List<String> value;
  String name;
  WaterFall({
    required this.data,
    // required this.value,
    // required this.labels,
    required this.name,
    super.key,
  });

  @override
  State<WaterFall> createState() => _WaterFallState();
}

class _WaterFallState extends State<WaterFall> {
  List<_ChartSampleData>? chartData;
  TooltipBehavior? _tooltipBehavior;

  // List<List<String>> getData() {
  //   List<List<String>> res = [];
  //   for (int i = 0; i < widget.value.length; i++) {
  //     widget.value[i] != "None"
  //         ? res.add([widget.labels[i], widget.value[i]])
  //         : res.add([widget.labels[i]]);
  //   }
  //   return res;
  // }

  @override
  void initState() {
    // widget.data = getData();
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildDefaultWaterfallChart();
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
        interval: 10,
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
      onDataLabelRender: (DataLabelRenderArgs dataLabelArgs) {
        dataLabelArgs.textStyle = const TextStyle(
          fontSize: 10,
        );
        widget.data[dataLabelArgs.pointIndex!].length == 2
            ? sum += double.parse(widget.data[dataLabelArgs.pointIndex!][1])
            : sum += 0;
        widget.data[dataLabelArgs.pointIndex!].length == 2
            ? (widget.data[dataLabelArgs.pointIndex!][1].contains("-") ||
                    widget.data[dataLabelArgs.pointIndex!][1] == "0" ||
                    widget.data
                            .indexOf(widget.data[dataLabelArgs.pointIndex!]) ==
                        0)
                ? dataLabelArgs.text = widget.data[dataLabelArgs.pointIndex!][1]
                : dataLabelArgs.text =
                    "${widget.data[dataLabelArgs.pointIndex!][1]}"
            : dataLabelArgs.text = sum.toString();
      },
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