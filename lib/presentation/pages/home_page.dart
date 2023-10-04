import 'package:flutter/material.dart';
import 'package:flutter_dashboard/data/repositories/windows_repository.dart';
import 'package:flutter_dashboard/domain/repositories/json_repository.dart';
import 'package:flutter_dashboard/presentation/colors.dart';
import 'package:flutter_dashboard/presentation/widgets/graph_widget.dart';
import 'package:flutter_dashboard/presentation/widgets/pie_graph.dart';
import 'package:flutter_dashboard/presentation/widgets/simple_bar.dart';
import 'package:flutter_dashboard/presentation/widgets/waterfall.dart';
import 'package:flutter_dashboard/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                            flex: 3,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 10, right: 10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      color: ThemeColors().secondary,
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(right: 30),
                                            child: Row(
                                              children: [
                                                ...snapshot.data!.charts.plots
                                                    .getRange(0, 1)
                                                    .map((e) => Expanded(
                                                          child:
                                                              LineChartSample2(
                                                            hidden: e.hidden,
                                                            isChosen:
                                                                List.filled(
                                                                    e.y.length,
                                                                    true),
                                                            names: e.y,
                                                            name: e.plotName,
                                                            data: repository
                                                                .getSeriesByName(
                                                                    e.x)
                                                                .map((e) => e
                                                                    .toString())
                                                                .toList(),
                                                            value: e.y
                                                                .map((seriesName) => repository
                                                                    .getSeriesByName(
                                                                        seriesName)
                                                                    .map((e) =>
                                                                        e.toString())
                                                                    .toList())
                                                                .toList(),
                                                          ),
                                                        ))
                                                    .toList(),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    : CircularProgressIndicator();
              default:
                return CircularProgressIndicator();
            }
          }),
    );
  }
}
