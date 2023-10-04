import 'package:flutter/material.dart';
import 'package:flutter_dashboard/data/repositories/windows_repository.dart';
import 'package:flutter_dashboard/domain/repositories/json_repository.dart';
import 'package:flutter_dashboard/presentation/colors.dart';
import 'package:flutter_dashboard/presentation/widgets/graph_widget.dart';
import 'package:flutter_dashboard/presentation/widgets/pie_graph.dart';
import 'package:flutter_dashboard/presentation/widgets/simple_bar.dart';
import 'package:flutter_dashboard/presentation/widgets/waterfall.dart';
import 'package:flutter_dashboard/service_locator.dart';

class NewSalesPage extends StatefulWidget {
  const NewSalesPage({super.key});

  @override
  State<NewSalesPage> createState() => _NewSalesPageState();
}

class _NewSalesPageState extends State<NewSalesPage> {
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
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return snapshot.data != null
                    ? SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: [
                              ...snapshot.data!.charts.barChart.map(
                                (e) => Container(
                                  margin: EdgeInsets.only(
                                      bottom: snapshot.data!.charts.barChart
                                                  .indexOf(e) !=
                                              snapshot.data!.charts.barChart
                                                      .length -
                                                  1
                                          ? 20
                                          : 0),
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  height: 400,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: ThemeColors().secondary,
                                  ),
                                  child: SimpleBar(
                                    isChosen: const [true],
                                    data: repository
                                        .getSeriesByName(e.x)
                                        .map((e) => e.toString())
                                        .toList(),
                                    name: e.plotName,
                                    value: e.y
                                        .map((seriesName) => repository
                                            .getSeriesByName(seriesName)
                                            .map((e) => e.toString())
                                            .toList())
                                        .toList(),
                                  ),
                                ),
                              )
                            ],
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
