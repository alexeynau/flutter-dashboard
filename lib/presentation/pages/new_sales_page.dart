import 'package:flutter/material.dart';
import 'package:flutter_dashboard/presentation/widgets/simple_bar.dart';

import '../../data/repositories/windows_repository.dart';
import '../../domain/repositories/json_repository.dart';
import '../../service_locator.dart';

import '../colors.dart';
import '../widgets/graph_widget.dart';

class NewSalesPage extends StatefulWidget {
  const NewSalesPage({super.key});

  @override
  State<NewSalesPage> createState() => _NewSalesPageState();
}

class _NewSalesPageState extends State<NewSalesPage> {
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
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...snapshot.data!.charts.plots
                              .getRange(4, 5)
                              .map(
                                (e) => Expanded(
                                  child: Container(
                                    color: ThemeColors().background01,
                                    child: LineChartSample2(
                                      hidden: e.hidden,
                                      isChosen: List.filled(e.y.length, true),
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
                          Container(
                            padding: const EdgeInsets.only(
                              top: 40,
                              left: 30,
                            ),
                            width: 400,
                            height: 600,
                            child: SimpleBar(
                              name: snapshot.data!.charts.barChart[0].plotName,
                              isChosen: const [true],
                              data: repository
                                  .getSeriesByName(
                                      snapshot.data!.charts.barChart[0].x)
                                  .map((e) => e.toString())
                                  .toList(),
                              value: snapshot.data!.charts.barChart[0].y
                                  .map((seriesName) => repository
                                      .getSeriesByName(seriesName)
                                      .map((e) => e.toString())
                                      .toList())
                                  .toList(),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          )
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
