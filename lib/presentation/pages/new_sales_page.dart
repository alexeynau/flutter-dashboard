import 'package:flutter/material.dart';
import 'package:flutter_dashboard/data/models/data.dart';
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
  late Future<DataAndPlots> fetchedData;
  @override
  void initState() {
    fetchedData = repository.getDataAndPlots();

    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   fetchedData = repository.getDataAndPlots();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // repository.eventStream.stream.listen((event) {
    //   setState(() {});
    // });
    return Container(
      padding: const EdgeInsets.all(20),
      color: ThemeColors().background01,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: StreamBuilder<DataAndPlots>(
          stream: repository.eventStream.stream,
          builder: (context, snapshot) {
            print("repaint stream builder");
            return FutureBuilder(
                future: fetchedData,
                builder: (context, snapshot) {
                  print("repaint future builder sales");
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return snapshot.data != null
                          ? Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      color: ThemeColors().secondary,
                                    ),
                                    child: WaterFall(
                                      name: snapshot
                                          .data!.charts.waterfall[0].plotName,
                                      names:
                                          snapshot.data!.charts.waterfall[0].y,
                                      labels: repository
                                          .getSeriesByName(snapshot
                                              .data!.charts.waterfall[0].x)
                                          .map((e) => e.toString())
                                          .toList(),
                                      value: snapshot
                                          .data!.charts.waterfall[0].y
                                          .map((seriesName) => repository
                                                  .getSeriesByName(seriesName)
                                                  .map((e) {
                                                if (e == null) return "None";
                                                return e.toString();
                                              }).toList())
                                          .toList(),
                                    ),
                                  ),
                                ),
                                // Expanded(
                                //   flex: 1,
                                //   child: Container(
                                //     margin: EdgeInsets.all(10),
                                //     decoration: BoxDecoration(
                                //       shape: BoxShape.rectangle,
                                //       borderRadius:
                                //           const BorderRadius.all(Radius.circular(15)),
                                //       color: ThemeColors().secondary,
                                //     ),
                                //   ),
                                // ),
                              ],
                            )
                          : Center(child: CircularProgressIndicator());
                    default:
                      return Center(child: CircularProgressIndicator());
                  }
                });
          }),
    );
  }
}
