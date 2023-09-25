import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/colors.dart';
import 'package:flutter_dashboard/presentation/widgets/bar_graph.dart';
import 'package:flutter_dashboard/presentation/widgets/column.dart';
import 'package:flutter_dashboard/presentation/widgets/graph_widget.dart';
import 'package:flutter_dashboard/presentation/widgets/pie_graph.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors().background01,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
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
                        names: const [
                          "Nums",
                        ],
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
                        names: const ["Alex", "Artem"],
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
                      child: LineChartSample2(
                        name: "Months",
                        names: const ["Alex", "Artem"],
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
                      child: LineChartSample2(
                        name: "Months",
                        names: const ["Alex", "Artem"],
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
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  // Expanded(
                  //   flex: 2,
                  //   child: Container(
                  //     color: ThemeColors().background01,
                  //     child: BarGraph(
                  //       name: "Выручка тыс.руб",
                  //       month: const [
                  //         "12.4",
                  //         "15.6",
                  //         "48.4",
                  //         "89.1",
                  //         "30.0",
                  //         "11.1",
                  //         "45.1",
                  //         "11.6",
                  //         "42.0",
                  //         "49.5",
                  //         "37.3",
                  //         "26.1",
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: Container(
                      color: ThemeColors().background01,
                      child: LineChartSample2(
                        name: "Names",
                        names: const ["Bob", "Rob", "Jorge"],
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
                      child: LineChartSample2(
                        name: "Months",
                        names: const ["Alex", "Artem"],
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
                      child: LineChartSample2(
                        name: "Months",
                        names: const ["Bob", "Rob"],
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
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: ThemeColors().background01,
                      child: BarGraph(
                        name: "Выручка тыс.руб",
                        month: const [
                          "12.4",
                          "15.6",
                          "48.4",
                          "89.1",
                          "30.0",
                          "11.1",
                          "45.1",
                          "11.6",
                          "42.0",
                          "49.5",
                          "37.3",
                          "26.1",
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: ThemeColors().background01,
                      child: PieGraph(
                        data: const [
                          ["First", "12"],
                          ["Second", "24"],
                          ["Fird", "67"],
                          ["Fourth", "54"],
                          ["Fifth", "63"],
                          ["Sizth", "63"],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   flex: 6,
            //   child: Container(
            //     color: ThemeColors().background01,
            //     child: ColumnChart(
            //       labelsOfCom: const [
            //         "Экспорт",
            //         "СНГ",
            //         "Внешний рынок",
            //         "Внутренний рынок"
            //       ],
            //       data: const [
            //         ["First", "12", "3", "56", "32", "12"],
            //         ["Second", "52", "15", "65", "12", "3"],
            //         ["Third", "13", "2", "43", "33", "6"],
            //         ["Fourth", "45", "2", "33", "0", "7"],
            //         ["Fifth", "83", "7", "38", "56", "54"],
            //         ["Sixth", "12", "5", "44", "11", "77"],
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
