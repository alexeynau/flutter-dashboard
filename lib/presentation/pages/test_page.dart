import 'package:flutter/material.dart';
import 'package:flutter_dashboard/domain/repositories/json_repository.dart';
import 'package:flutter_dashboard/presentation/colors.dart';
import 'package:flutter_dashboard/presentation/widgets/graph_widget.dart';
import 'package:flutter_dashboard/presentation/widgets/pie_graph.dart';
import 'package:flutter_dashboard/presentation/widgets/simple_bar.dart';
import 'package:flutter_dashboard/presentation/widgets/waterfall.dart';
import 'package:flutter_dashboard/service_locator.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  JsonRepository repository = getIt.get<JsonRepository>();

  @override
  void initState() {
    repository.eventStream.stream.listen((event) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> labels = [
      "янв",
      "фев",
      "мар",
      "Итог 1",
      "апр",
      "май",
      "июн",
      "Итог 2",
      "июл",
      "авг",
      "сен",
      "Итог 3",
      "окт",
      "ноя",
      "дек",
      "Итог 4"
    ];
    List<String> value = [
      "52",
      "23",
      "-11",
      "None",
      "-15",
      "28",
      "30",
      "None",
      "-50",
      "22",
      "28",
      "None",
      "17",
      "-39",
      "-17",
      "None"
    ];
    List<List<String>> chartData = [];
    for (int i = 0; i < value.length; i++) {
      value[i] != "None"
          ? chartData.add([labels[i], value[i]])
          : chartData.add([labels[i]]);
    }
    return Container(
      padding: const EdgeInsets.all(20),
      color: ThemeColors().background01,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
          future: repository.getDataAndPlots(),
          builder: (context, snapshot) {
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
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
                                          .getRange(0, 3)
                                          .map((e) => Expanded(
                                                child: LineChartSample2(
                                                  hidden: e.hidden,
                                                  isChosen: List.filled(
                                                      e.y.length, true),
                                                  names: e.y,
                                                  name: e.plotName,
                                                  data: repository
                                                      .getSeriesByName(e.x)
                                                      .map((e) => e.toString())
                                                      .toList(),
                                                  value: e.y
                                                      .map((seriesName) =>
                                                          repository
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
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: ThemeColors().secondary,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 20,
                                      left: 20,
                                    ),
                                    child: SimpleBar(
                                      name: snapshot
                                          .data!.charts.barChart[0].plotName,
                                      isChosen: const [true],
                                      data: repository
                                          .getSeriesByName(snapshot
                                              .data!.charts.barChart[0].x)
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
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: ThemeColors().secondary,
                                  ),
                                  // child: WaterFall(
                                  //   name: "Some Plot",
                                  //   labels: const [
                                  //     "янв",
                                  //     "фев",
                                  //     "мар",
                                  //     "Итог 1",
                                  //     "апр",
                                  //     "май",
                                  //     "июн",
                                  //     "Итог 2",
                                  //     "июл",
                                  //     "авг",
                                  //     "сен",
                                  //     "Итог 3",
                                  //     "окт",
                                  //     "ноя",
                                  //     "дек",
                                  //     "Итог 4"
                                  //   ],
                                  //   value: const [
                                  //     "52",
                                  //     "23",
                                  //     "-11",
                                  //     "None",
                                  //     "-15",
                                  //     "28",
                                  //     "30",
                                  //     "None",
                                  //     "-50",
                                  //     "22",
                                  //     "28",
                                  //     "None",
                                  //     "17",
                                  //     "-39",
                                  //     "-17",
                                  //     "None",
                                  //   ],
                                  // ),
                                  child: WaterFall(
                                      data: chartData, name: "Test plot"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: ThemeColors().secondary,
                    ),
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
                )
              ],
            );
          }),
    );
  }
}
