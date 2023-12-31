import 'package:flutter/material.dart';
import '../../data/repositories/windows_repository.dart';
import '../colors.dart';
import '../widgets/graph_with_hiden.dart';
import '../widgets/waterfall.dart';
import '../../service_locator.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
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
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
      color: ThemeColors().background01,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
          future: repository.getDataAndPlots(),
          builder: (context, snapshot) {
            print("repaint future builder test");
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return snapshot.data != null
                    ? Container(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: [
                                ...snapshot.data!.charts.waterfall.map(
                                  (e) => Container(
                                      margin: const EdgeInsets.only(bottom: 20),
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      height: 500,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        color: ThemeColors().secondary,
                                      ),
                                      child: WaterFall(
                                          names: e.y,
                                          value: e.y
                                              .map((seriesName) => repository
                                                      .getSeriesByName(
                                                          seriesName)
                                                      .map((e) {
                                                    if (e == null)
                                                      return "None";
                                                    return e.toString();
                                                  }).toList())
                                              .toList(),
                                          labels: repository
                                              .getSeriesByName(e.x)
                                              .map((e) => e.toString())
                                              .toList(),
                                          name: e.plotName)),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, right: 30),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: ThemeColors().secondary,
                                  ),
                                  height: 600,
                                  child: LineChartSampleHidden(
                                    nameX: snapshot.data!.charts.plots[7].x,
                                    hidden:
                                        snapshot.data!.charts.plots[7].hidden,
                                    isChosen: List.filled(
                                        snapshot.data!.charts.plots[7].y.length,
                                        true),
                                    names: snapshot.data!.charts.plots[7].y,
                                    name:
                                        snapshot.data!.charts.plots[7].plotName,
                                    data: repository
                                        .getSeriesByName(
                                            snapshot.data!.charts.plots[7].x)
                                        .map((e) => e.toString())
                                        .toList(),
                                    value: snapshot.data!.charts.plots[7].y
                                        .map((seriesName) => repository
                                            .getSeriesByName(seriesName)
                                            .map((e) => e.toString())
                                            .toList())
                                        .toList(),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, right: 30),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: ThemeColors().secondary,
                                  ),
                                  height: 600,
                                  child: LineChartSampleHidden(
                                    nameX: snapshot.data!.charts.plots[8].x,
                                    hidden:
                                        snapshot.data!.charts.plots[8].hidden,
                                    isChosen: List.filled(
                                        snapshot.data!.charts.plots[8].y.length,
                                        true),
                                    names: snapshot.data!.charts.plots[8].y,
                                    name:
                                        snapshot.data!.charts.plots[8].plotName,
                                    data: repository
                                        .getSeriesByName(
                                            snapshot.data!.charts.plots[8].x)
                                        .map((e) => e.toString())
                                        .toList(),
                                    value: snapshot.data!.charts.plots[8].y
                                        .map((seriesName) => repository
                                            .getSeriesByName(seriesName)
                                            .map((e) => e.toString())
                                            .toList())
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator());
              default:
                return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
