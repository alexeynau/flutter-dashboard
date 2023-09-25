import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/data/models/data.dart';
import 'package:flutter_dashboard/domain/repositories/json_repository.dart';
import 'package:flutter_dashboard/presentation/bloc/chart_bloc/chart_bloc.dart';
import 'package:flutter_dashboard/presentation/widgets/graph_widget.dart';
import 'package:flutter_dashboard/service_locator.dart';

import 'package:fl_chart/fl_chart.dart';

class ListenWidget extends StatefulWidget {
  final String name;
  final String x;
  final List<String> y;
  const ListenWidget(
      {super.key, required this.x, required this.y, required this.name});

  @override
  State<ListenWidget> createState() => _ListenWidgetState();
}

class _ListenWidgetState extends State<ListenWidget> {
  JsonRepository repository = getIt.get<JsonRepository>();

  @override
  void initState() {
    // JsonRepository repository = getIt.get<JsonRepository>();
    print("repaint");
    repository.eventStream.stream.listen((event) {
      if (widget.x.contains(event.name) || widget.y.contains(event.name)) {
        context.read<ChartBloc>().add(LoadChart(
              Plot(
                name: widget.name,
                x: widget.x,
                y: widget.y,
                stats: " ",
              ),
            ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartBloc, ChartState>(
      builder: (context, state) {
        print(state);
        if (state is ChartInitial) {
          context.read<ChartBloc>().add(
                LoadChart(
                  Plot(
                    name: widget.name,
                    x: widget.x,
                    y: widget.y,
                    stats: " ",
                  ),
                ),
              );
        } else if (state is ChartLoaded) {
          return LineChartSample2(
            data: repository
                .getSeriesByName(widget.x)
                .map((e) => e.toString())
                .toList(),
            value: widget.y
                .map((y) => repository
                    .getSeriesByName(y)
                    .map((e) => e.toString())
                    .toList())
                .toList(),
          );
        } else if (state is ChartLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ChartError) {
          return const Text("Непредвиденная ошибка");
        }
        return Container();
      },
    );
    // FutureBuilder(
    //   future: repository.getDataAndPlots(),
    //   builder: (context, snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.done:
    //         if (snapshot.hasData) {
    //           if (snapshot.data!.data.isNotEmpty &&
    //               snapshot.data!.charts.plots.isNotEmpty) {
    //             return LineChartSample2(
    //               data: repository
    //                   .getSeriesByName(widget.x)
    //                   .map((e) => e.toString())
    //                   .toList(),
    //               value: widget.y
    //                   .map((y) => repository
    //                       .getSeriesByName(y)
    //                       .map((e) => e.toString())
    //                       .toList())
    //                   .toList(),
    //             );

    // LineChart(LineChartData(lineBarsData: [
    //   ...widget.y.map(
    //     (seriesName) {
    //       var ys = repository.getSeriesByName(
    //           seriesName, snapshot.data!.data);
    //       return LineChartBarData(
    //         spots: xs
    //             .map((index) => FlSpot(index.toDouble(), ys[index]))
    //             .toList(),
    //         //  snapshot.data!.data.firstWhere((data) => seriesName == data.name).series.map((y) => FlSpot(snapshot.data!.data.firstWhere((x) => seriesName == data.name), y)).toList(),
    //       );
    //     },
    //   ).toList()
    // ]));

    // Column(
    //   children: [
    //     Text("x - ${widget.x}, y - ${widget.y}"),
    //     Text(
    //         "x = ${snapshot.data!.data.firstWhere((element) => (element.name == widget.x)).series.toString()}"),
    //     ...widget.y.map(
    //       (e) {
    //         return Text(
    //             "${snapshot.data!.data.firstWhere((element) => (element.name == e)).series}");
    //       },
    //     ).toList(),
    //     Text(snapshot.data!.charts.plots
    //         .firstWhere((element) => (element.x == widget.x))
    //         .stats),
    //   ],
    // );
    //           }
    //         } else
    //           return CircularProgressIndicator();

    //         break;
    //       case ConnectionState.active:
    //         if (snapshot.hasData) {
    //           return Text(snapshot.data.toString());
    //         }

    //         break;
    //       default:
    //         return const CircularProgressIndicator();
    //     }
    //     return const CircularProgressIndicator();
    //   },
    // );
  }
}
