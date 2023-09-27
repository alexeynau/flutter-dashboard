import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/data/models/data.dart';
import 'package:flutter_dashboard/data/repositories/windows_repository.dart';
// import 'package:flutter_dashboard/presentation/bloc/canvas_bloc/canvas_bloc.dart';
import 'package:flutter_dashboard/presentation/widgets/listen_widget.dart';
import 'package:flutter_dashboard/presentation/widgets/old_selector.dart';

import '../../domain/repositories/json_repository.dart';
import '../../service_locator.dart';
// import '../bloc/chart_bloc/chart_bloc.dart';
import '../colors.dart';
import '../widgets/bar_graph.dart';
import '../widgets/column.dart';
import '../widgets/graph_widget.dart';
import '../widgets/pie_graph.dart';
import '../widgets/selector_widget.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  WindowsRepository repository = getIt.get<WindowsRepository>();

  @override
  void initState() {
    print("repaint");
    repository.eventStream.stream.listen((event) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors().background01,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
          future: repository.getDataAndPlots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return snapshot.data != null
                    ? Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                ...snapshot.data!.charts.plots
                                    .getRange(0, 2)
                                    .map(
                                      (e) => Expanded(
                                        child: Container(
                                          color: ThemeColors().background01,
                                          child: LineChartSample2(
                                            hidden: e.hidden,
                                            isChosen:
                                                List.filled(e.y.length, true),
                                            names: e.y,
                                            name: e.plotName,
                                            data: repository
                                                .getSeriesByName(e.x)
                                                .map((e) => e.toString())
                                                .toList(),
                                            value: e.y
                                                .map((seriesName) => repository
                                                    .getSeriesByName(seriesName)
                                                    .map((e) => e.toString())
                                                    .toList())
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                ...snapshot.data!.charts.plots
                                    .getRange(2, 4)
                                    .map(
                                      (e) => Expanded(
                                        child: Container(
                                          color: ThemeColors().background01,
                                          child: LineChartSample2(
                                            hidden: e.hidden,
                                            isChosen:
                                                List.filled(e.y.length, true),
                                            names: e.y,
                                            name: e.plotName,
                                            data: repository
                                                .getSeriesByName(e.x)
                                                .map((e) => e.toString())
                                                .toList(),
                                            value: e.y
                                                .map((seriesName) => repository
                                                    .getSeriesByName(seriesName)
                                                    .map((e) => e.toString())
                                                    .toList())
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ],
                            ),
                          ),
                          // Expanded(
                          //   flex: 4,
                          //   child: Row(
                          //     children: [
                          //       ...snapshot.data!.charts.plots
                          //           .getRange(3, 7)
                          //           .map(
                          //             (e) => Expanded(
                          //               child: Container(
                          //                 color: ThemeColors().background01,
                          //                 child: LineChartSample2(
                          //                   isChosen:
                          //                       List.filled(e.y.length, true),
                          //                   names: e.y,
                          //                   name: e.plotName,
                          //                   data: repository
                          //                       .getSeriesByName(e.x)
                          //                       .map((e) => e.toString())
                          //                       .toList(),
                          //                   value: e.y
                          //                       .map((seriesName) =>
                          //                           repository
                          //                               .getSeriesByName(
                          //                                   seriesName)
                          //                               .map((e) =>
                          //                                   e.toString())
                          //                               .toList())
                          //                       .toList(),
                          //                 ),
                          //               ),
                          //             ),
                          //           )
                          //           .toList(),
                          //     ],
                          //   ),
                          // ),
                          // Expanded(
                          //   flex: 6,
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         flex: 2,
                          //         child: Container(
                          //           color: ThemeColors().background01,
                          //           child: BarGraph(
                          //             name: snapshot
                          //                 .data!.charts.barPlot.plotName,
                          //             month: repository
                          //                 .getSeriesByName(
                          //                     snapshot.data!.charts.barPlot.y)
                          //                 .map((e) => e.toString())
                          //                 .toList(),
                          //           ),
                          //         ),
                          //       ),
                          //       Expanded(
                          //         child: Container(
                          //           padding: EdgeInsets.only(right: 30),
                          //           color: ThemeColors().background01,
                          //           child: Builder(builder: (context) {
                          //             var labels = repository
                          //                 .getSeriesByName(snapshot
                          //                     .data!.charts.pieChart.x)
                          //                 .map(
                          //                   (e) => e.toString(),
                          //                 )
                          //                 .toList();

                          //             var values = repository
                          //                 .getSeriesByName(snapshot
                          //                     .data!.charts.pieChart.y)
                          //                 .map(
                          //                   (e) => e.toString(),
                          //                 )
                          //                 .toList();
                          //             return PieGraph(
                          //               data: List.generate(labels.length,
                          //                       (index) => index)
                          //                   .map((index) => [
                          //                         labels[index],
                          //                         values[index]
                          //                       ])
                          //                   .toList(),
                          //             );
                          //           }),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // // Expanded(
                          // //   flex: 6,
                          // //   child: Container(
                          // //     color: ThemeColors().background01,
                          // //     child: ColumnChart(
                          // //       labelsOfCom: const [
                          // //         "Экспорт",
                          // //         "СНГ",
                          // //         "Что-то",
                          // //         "Внутренний рынок"
                          // //       ],
                          // //       data: const [
                          // //         ["First", "12", "3", "56", "32", "0"],
                          // //         ["Second", "52", "15", "65", "12", "0"],
                          // //         ["Third", "13", "2", "43", "33", "0"],
                          // //         ["Fourth", "45", "2", "33", "0", "0"],
                          // //         ["Fifth", "83", "7", "38", "56", "0"],
                          // //         ["Sixth", "12", "5", "44", "11", "0"],
                          // //       ],
                          // //     ),
                          // //   ),
                          // // ),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );

              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          }),
    );
  }
}
