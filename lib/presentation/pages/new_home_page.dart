import 'package:flutter/material.dart';
import 'package:flutter_dashboard/data/repositories/windows_repository.dart';
import 'package:flutter_dashboard/domain/repositories/json_repository.dart';
import 'package:flutter_dashboard/presentation/colors.dart';
import 'package:flutter_dashboard/presentation/widgets/graph_widget.dart';
import 'package:flutter_dashboard/presentation/widgets/pie_graph.dart';
import 'package:flutter_dashboard/presentation/widgets/simple_bar.dart';
import 'package:flutter_dashboard/presentation/widgets/waterfall.dart';
import 'package:flutter_dashboard/service_locator.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  WindowsRepository repository = getIt.get<WindowsRepository>();

  @override
  void initState() {
    repository.eventStream.stream.listen((event) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: ThemeColors().background01,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
          future: repository.getDataAndPlots(),
          builder: (context, snapshot) {
            print("repaint future builder home");
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return snapshot.data != null
                    ? Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    right: 5,
                                    bottom: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: ThemeColors().secondary,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: LineChartSample2(
                                      isChosen: List.filled(
                                          snapshot
                                              .data!.charts.plots[0].y.length,
                                          true),
                                      names: snapshot.data!.charts.plots[0].y,
                                      name: snapshot
                                          .data!.charts.plots[0].plotName,
                                      data: repository
                                          .getSeriesByName(
                                              snapshot.data!.charts.plots[0].x)
                                          .map((e) => e.toString())
                                          .toList(),
                                      value: snapshot.data!.charts.plots[0].y
                                          .map((seriesName) => repository
                                              .getSeriesByName(seriesName)
                                              .map((e) => e.toString())
                                              .toList())
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    right: 5,
                                    top: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: ThemeColors().secondary,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: LineChartSample2(
                                      isChosen: List.filled(
                                          snapshot
                                              .data!.charts.plots[1].y.length,
                                          true),
                                      names: snapshot.data!.charts.plots[1].y,
                                      name: snapshot
                                          .data!.charts.plots[1].plotName,
                                      data: repository
                                          .getSeriesByName(
                                              snapshot.data!.charts.plots[1].x)
                                          .map((e) => e.toString())
                                          .toList(),
                                      value: snapshot.data!.charts.plots[1].y
                                          .map((seriesName) => repository
                                              .getSeriesByName(seriesName)
                                              .map((e) => e.toString())
                                              .toList())
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    left: 5,
                                    bottom: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: ThemeColors().secondary,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: LineChartSample2(
                                      isChosen: List.filled(
                                          snapshot
                                              .data!.charts.plots[2].y.length,
                                          true),
                                      names: snapshot.data!.charts.plots[2].y,
                                      name: snapshot
                                          .data!.charts.plots[2].plotName,
                                      data: repository
                                          .getSeriesByName(
                                              snapshot.data!.charts.plots[2].x)
                                          .map((e) => e.toString())
                                          .toList(),
                                      value: snapshot.data!.charts.plots[2].y
                                          .map((seriesName) => repository
                                              .getSeriesByName(seriesName)
                                              .map((e) => e.toString())
                                              .toList())
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    top: 5,
                                    left: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: ThemeColors().secondary,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: LineChartSample2(
                                      isChosen: List.filled(
                                          snapshot
                                              .data!.charts.plots[3].y.length,
                                          true),
                                      names: snapshot.data!.charts.plots[3].y,
                                      name: snapshot
                                          .data!.charts.plots[3].plotName,
                                      data: repository
                                          .getSeriesByName(
                                              snapshot.data!.charts.plots[3].x)
                                          .map((e) => e.toString())
                                          .toList(),
                                      value: snapshot.data!.charts.plots[3].y
                                          .map((seriesName) => repository
                                              .getSeriesByName(seriesName)
                                              .map((e) => e.toString())
                                              .toList())
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ],
                      )
                    : Center(child: CircularProgressIndicator());
              default:
                return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
