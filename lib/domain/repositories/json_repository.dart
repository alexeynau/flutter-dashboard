import 'dart:async';

import 'package:flutter_dashboard/data/models/data.dart';

import '../../data/models/event_model.dart';

abstract class JsonRepository {
  Future<DataAndPlots> getDataAndPlots();
  Future<Datum> getDatum();
  StreamController<StreamEvent> get eventStream;
  List<dynamic> getSeriesByName(String name);
  List<Plot> getPlots();
}
