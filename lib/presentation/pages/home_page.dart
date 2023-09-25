import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/data/models/data.dart';
import 'package:flutter_dashboard/presentation/bloc/canvas_bloc/canvas_bloc.dart';
import 'package:flutter_dashboard/presentation/widgets/listen_widget.dart';
import 'package:flutter_dashboard/presentation/widgets/old_selector.dart';

import '../../domain/repositories/json_repository.dart';
import '../../service_locator.dart';
import '../colors.dart';
import '../widgets/bar_graph.dart';
import '../widgets/column.dart';
import '../widgets/graph_widget.dart';
import '../widgets/pie_graph.dart';
import '../widgets/selector_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  JsonRepository repository = getIt.get<JsonRepository>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: BlocBuilder<CanvasBloc, CanvasState>(
      builder: (context, state) {
        if (state is CanvasInitial) {
          BlocProvider.of<CanvasBloc>(context).add(LoadCanvas());
        }
        if (state is CanvasLoaded) {
          return FutureBuilder(
              future: repository.getDataAndPlots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print("HOME ${snapshot.data}");
                  return Container(
                    color: ThemeColors().background01,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              ...snapshot.data!.charts.plots
                                  .getRange(0, 3)
                                  .map(
                                    (e) => Expanded(
                                      child: Container(
                                        color: ThemeColors().background01,
                                        child: SelectorWidget(
                                            x: e.x, y: e.y, name: e.plotName),
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
                                  .getRange(3, 7)
                                  .map(
                                    (e) => Expanded(
                                      child: Container(
                                        color: ThemeColors().background01,
                                        child: SelectorWidget(
                                            x: e.x, y: e.y, name: e.plotName),
                                      ),
                                    ),
                                  )
                                  .toList(),
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
                                    name:
                                        snapshot.data!.charts.barPlot.plotName,
                                    month: repository
                                        .getSeriesByName(
                                            snapshot.data!.charts.barPlot.y)
                                        .map((e) => e.toString())
                                        .toList(),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: ThemeColors().background01,
                                  child: Builder(builder: (context) {
                                    var labels = repository
                                        .getSeriesByName(
                                            snapshot.data!.charts.pieChart.x)
                                        .map(
                                          (e) => e.toString(),
                                        )
                                        .toList();

                                    var values = repository
                                        .getSeriesByName(
                                            snapshot.data!.charts.pieChart.y)
                                        .map(
                                          (e) => e.toString(),
                                        )
                                        .toList();
                                    return PieGraph(
                                      data: List.generate(
                                              labels.length, (index) => index)
                                          .map((index) =>
                                              [labels[index], values[index]])
                                          .toList(),
                                    );
                                  }),
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
                        //         "Что-то",
                        //         "Внутренний рынок"
                        //       ],
                        //       data: const [
                        //         ["First", "12", "3", "56", "32", "0"],
                        //         ["Second", "52", "15", "65", "12", "0"],
                        //         ["Third", "13", "2", "43", "33", "0"],
                        //         ["Fourth", "45", "2", "33", "0", "0"],
                        //         ["Fifth", "83", "7", "38", "56", "0"],
                        //         ["Sixth", "12", "5", "44", "11", "0"],
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        }
      },
    ));
  }
}
