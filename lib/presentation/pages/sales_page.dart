import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/colors.dart';
import 'package:flutter_dashboard/presentation/widgets/column.dart';
import 'package:flutter_dashboard/presentation/widgets/graph_widget.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: ThemeColors().background01,
                      child: LineChartSample2(
                        data: const [
                          "First",
                          "Second",
                          "Third",
                          "Fourth",
                          "Fifth",
                          "Sixth",
                        ],
                        value: const [
                          [
                            "10",
                            "29",
                            "34",
                            "10",
                            "23",
                            "31",
                          ]
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: ThemeColors().background01,
                      child: LineChartSample2(
                        data: const [
                          "Jan",
                          "Feb",
                          "Mar",
                          "Apr",
                          "May",
                          "Jun",
                          "Jul",
                          "Aug",
                          "Sep",
                          "Oct",
                          "Nov",
                          "Dec"
                        ],
                        value: const [
                          [
                            "1",
                            "2",
                            "3",
                            "1",
                            "2",
                            "3",
                            "1",
                            "2",
                            "3",
                            "1",
                            "2",
                            "3"
                          ],
                          [
                            "3",
                            "1",
                            "6",
                            "7",
                            "2",
                            "9",
                            "3",
                            "1",
                            "2",
                            "3",
                            "4",
                            "8"
                          ]
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: ThemeColors().background01,
                      child: LineChartSample2(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: ThemeColors().background01,
                      child: LineChartSample2(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: ThemeColors().background01,
                      child: LineChartSample2(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: ThemeColors().background01,
                      child: LineChartSample2(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: ThemeColors().background01,
                      child: LineChartSample2(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: ThemeColors().background01,
                      child: LineChartSample2(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                color: ThemeColors().background01,
                child: ColumnChart(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
