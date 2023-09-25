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
      // if (widget.x.contains(event.name) || widget.y.contains(event.name)) {
      //   context.read<ChartBloc>().add(LoadChart(
      //         Plot(
      //           plotName: widget.name,
      //           x: widget.x,
      //           y: widget.y,
      //           stats: " ",
      //         ),
      //       ));
      // }
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
                    plotName: widget.name,
                    x: widget.x,
                    y: widget.y,
                    stats: "123",
                  ),
                ),
              );
        } else if (state is ChartLoaded) {
          return FutureBuilder(
              future: repository.getDataAndPlots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return LineChartSample2(
                      name: widget.name,
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

                  default:
                    return CircularProgressIndicator();
                }
              });
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
  }
}
