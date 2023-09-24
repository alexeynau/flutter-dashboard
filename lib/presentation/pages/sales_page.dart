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
                        name: "Numbers",
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
                        name: "Months",
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
                      child: LineChartSample2(
                        name: "Names",
                        data: const [
                          "Alexey",
                          "Dmitriy",
                          "Georgy",
                        ],
                        value: const [
                          [
                            "12",
                            "271",
                            "220",
                          ],
                          [
                            "120",
                            "22",
                            "229",
                          ],
                          [
                            "1",
                            "145",
                            "300",
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
              flex: 6,
              child: Container(
                color: ThemeColors().background01,
                child: ColumnChart(
                  data: const [
                    ["First", "12", "3", "56"],
                    ["Second", "52", "15", "65"],
                    ["Third", "13", "2", "43"],
                    ["Fourth", "45", "2", "33"],
                    ["Fifth", "83", "7", "38"],
                    ["Sixth", "12", "5", "44"],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
