import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_dashboard/data/models/data.dart';
import 'package:flutter_dashboard/data/models/event_model.dart';
import 'package:http/http.dart' as http;

abstract class JsonRemoteData {
  StreamController<StreamEvent> get eventStream;
  Future<DataAndPlots> loadJson();
  Future<void> serverWatcher(int seconds);
}

class JsonRemoteDataImpl implements JsonRemoteData {
  late StreamController<StreamEvent> _eventStream;
  DataAndPlots _dataAndPlots =
      DataAndPlots(data: [], charts: Charts(plots: [], pieChart: []));
  Future<void> serverWatcher(int seconds) async {
    _eventStream = StreamController.broadcast();
    print("start watching");
    String url = "http://localhost:8000/";
    var response = await http.get(Uri.parse(url));
    print("got response");
    _dataAndPlots = dataAndPlotsFromJson(response.body);
    print(response.body);
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
          _dataAndPlots = dataAndPlotsFromJson(response.body);

          for (var data in compareData(startDataAndPlots, _dataAndPlots)) {
            eventStream.add(StreamEvent(data: data, name: data.name));
          }
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

  StreamController<StreamEvent> get eventStream => _eventStream;
  @override
  Future<DataAndPlots> loadJson() async {
    return _dataAndPlots;
  }
}
