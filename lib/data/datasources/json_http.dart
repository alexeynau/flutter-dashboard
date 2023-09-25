import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_dashboard/data/models/data.dart';
import 'package:flutter_dashboard/data/models/event_model.dart';
import 'package:http/http.dart' as http;

abstract class JsonRemoteData {
  StreamController<DataAndPlots> get eventStream;
  Future<DataAndPlots> loadJson();
  Future<void> serverWatcher(int seconds);
  List<Datum> getData();
  Future<Charts> getCharts();
}

class JsonRemoteDataImpl implements JsonRemoteData {
  late StreamController<DataAndPlots> _eventStream;
  late DataAndPlots _dataAndPlots;

  @override
  Future<void> serverWatcher(int seconds) async {
    _eventStream = StreamController.broadcast();
    print("start watching");
    String url = "http://localhost:8000/";
    var response = await http.get(Uri.parse(url));
    print("got response");

    _dataAndPlots = dataAndPlotsFromJson(utf8.decode(response.bodyBytes));
    String finalText = "";

    while (true) {
      print("Watching ...");
      if (response.statusCode == 200) {
        String startText = finalText;
        await Future.delayed(Duration(seconds: seconds));
        response = await http.get(Uri.parse(url));
        finalText = response.body;

        if (startText != finalText) {
          print("new event");
          var startDataAndPlots = _dataAndPlots;
          _dataAndPlots = dataAndPlotsFromJson(utf8.decode(response.bodyBytes));

          eventStream.add(_dataAndPlots);
          // for (var data in compareData(startDataAndPlots, _dataAndPlots)) {
          //   eventStream.add(StreamEvent(data: data, name: data.name));
        } else {
          print("nothing changed");
        }
      } else {
        print(response.statusCode);
      }
    }
  }

  List<Datum> compareData(DataAndPlots start, DataAndPlots other) {
    var firstSet = Set<Datum>.from(start.data);
    var secondSet = Set<Datum>.from(other.data);
    var difference = secondSet.difference(firstSet);
    return difference.toList();
  }

  Set<T> symmetricDifference<T>(Set<T> set1, Set<T> set2) {
    return set1.difference(set2).union(set2.difference(set1));
  }

  @override
  StreamController<DataAndPlots> get eventStream => _eventStream;

  @override
  Future<DataAndPlots> loadJson() async {
    return _dataAndPlots;
  }

  @override
  List<Datum> getData() {
    return _dataAndPlots.data;
  }

  @override
  Future<Charts> getCharts() async {
    return (await loadJson()).charts;
  }
}
