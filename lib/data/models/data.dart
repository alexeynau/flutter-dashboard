// To parse this JSON data, do
//
//     final dataAndPlots = dataAndPlotsFromJson(jsonString);

import 'dart:convert';

DataAndPlots dataAndPlotsFromJson(String str) =>
    DataAndPlots.fromJson(json.decode(str));

String dataAndPlotsToJson(DataAndPlots data) => json.encode(data.toJson());

class DataAndPlots {
  final List<Datum> data;
  final Charts charts;

  DataAndPlots({
    required this.data,
    required this.charts,
  });

  factory DataAndPlots.fromJson(Map<String, dynamic> json) => DataAndPlots(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        charts: Charts.fromJson(json["charts"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "charts": charts.toJson(),
      };
}

class Charts {
  final List<BarChart> plots;
  final List<BarChart> barChart;

  Charts({
    required this.plots,
    required this.barChart,
  });

  factory Charts.fromJson(Map<String, dynamic> json) => Charts(
        plots:
            List<BarChart>.from(json["plots"].map((x) => BarChart.fromJson(x))),
        barChart: List<BarChart>.from(
            json["bar chart"].map((x) => BarChart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "plots": List<dynamic>.from(plots.map((x) => x.toJson())),
        "bar chart": List<dynamic>.from(barChart.map((x) => x.toJson())),
      };
}

class BarChart {
  final String plotName;
  final String x;
  final List<String> y;
  final List<List<String>>? hidden;

  BarChart({
    required this.plotName,
    required this.x,
    required this.y,
    this.hidden,
  });

  factory BarChart.fromJson(Map<String, dynamic> json) => BarChart(
        plotName: json["plot_name"],
        x: json["x"],
        y: List<String>.from(json["y"].map((x) => x)),
        hidden: json["hidden"] == null
            ? []
            : List<List<String>>.from(
                json["hidden"]!.map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "plot_name": plotName,
        "x": x,
        "y": List<dynamic>.from(y.map((x) => x)),
        "hidden": hidden == null
            ? []
            : List<dynamic>.from(
                hidden!.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class Datum {
  final String name;
  final List<dynamic> series;

  Datum({
    required this.name,
    required this.series,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        series: List<dynamic>.from(json["series"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "series": List<dynamic>.from(series.map((x) => x)),
      };
}
