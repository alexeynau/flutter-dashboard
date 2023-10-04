import 'package:flutter/material.dart';
import '../../data/models/data.dart';
import '../../data/repositories/windows_repository.dart';
import '../colors.dart';
import '../widgets/simple_bar.dart';
import '../../service_locator.dart';

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
                          ? SingleChildScrollView(
                              child: Container(
                                child: Column(
                                  children: [
                                    ...snapshot.data!.charts.barChart.map(
                                      (e) => Container(
                                        margin: EdgeInsets.only(
                                            bottom: snapshot
                                                        .data!.charts.barChart
                                                        .indexOf(e) !=
                                                    snapshot.data!.charts
                                                            .barChart.length -
                                                        1
                                                ? 20
                                                : 0),
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        height: 500,
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
                });
          }),
    );
  }
}
