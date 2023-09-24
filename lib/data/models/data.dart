// To parse this JSON data, do
//
//     final dataAndPlots = dataAndPlotsFromJson(jsonString);

import 'dart:convert';

DataAndPlots dataAndPlotsFromJson(String str) =>
    DataAndPlots.fromJson(json.decode(str));

String dataAndPlotsToJson(DataAndPlots data) => json.encode(data.toJson());

class DataAndPlots {
  final List<Datum> data;
  final List<Plot> plots;

  DataAndPlots({
    required this.data,
    required this.plots,
  });

  factory DataAndPlots.fromJson(Map<String, dynamic> json) => DataAndPlots(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        plots: List<Plot>.from(json["plots"].map((x) => Plot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "plots": List<dynamic>.from(plots.map((x) => x.toJson())),
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

class Plot {
  final String x;
  final String y;
  final String stats;
  final Param param;

  Plot({
    required this.x,
    required this.y,
    required this.stats,
    required this.param,
  });

  factory Plot.fromJson(Map<String, dynamic> json) => Plot(
        x: json["x"],
        y: json["y"],
        stats: json["stats"],
        param: Param.fromJson(json["param"]),
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "stats": stats,
        "param": param.toJson(),
      };
}

class Param {
  final int bp;

  Param({
    required this.bp,
  });

  factory Param.fromJson(Map<String, dynamic> json) => Param(
        bp: json["bp"],
      );

  Map<String, dynamic> toJson() => {
        "bp": bp,
      };
}
