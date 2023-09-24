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
  final List<Plot> plots;
  final List<PieChart> pieChart;

  Charts({
    required this.plots,
    required this.pieChart,
  });

  factory Charts.fromJson(Map<String, dynamic> json) => Charts(
        plots: List<Plot>.from(json["plots"].map((x) => Plot.fromJson(x))),
        pieChart: List<PieChart>.from(
            json["pie_chart"].map((x) => PieChart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "plots": List<dynamic>.from(plots.map((x) => x.toJson())),
        "pie_chart": List<dynamic>.from(pieChart.map((x) => x.toJson())),
      };
}

class PieChart {
  final String x;
  final List<Y> y;

  PieChart({
    required this.x,
    required this.y,
  });

  factory PieChart.fromJson(Map<String, dynamic> json) => PieChart(
        x: json["x"],
        y: List<Y>.from(json["y"].map((x) => Y.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": List<dynamic>.from(y.map((x) => x.toJson())),
      };
}

class Y {
  final String name;
  final double percent;

  Y({
    required this.name,
    required this.percent,
  });

  factory Y.fromJson(Map<String, dynamic> json) => Y(
        name: json["name"],
        percent: json["percent"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "percent": percent,
      };
}

class Plot {
  final String x;
  final List<String> y;
  final String stats;

  Plot({
    required this.x,
    required this.y,
    required this.stats,
  });

  factory Plot.fromJson(Map<String, dynamic> json) => Plot(
        x: json["x"],
        y: List<String>.from(json["y"].map((x) => x)),
        stats: json["stats"],
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": List<dynamic>.from(y.map((x) => x)),
        "stats": stats,
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
