import 'dart:async';

import 'package:flutter_dashboard/data/models/data.dart';

import '../../data/models/event_model.dart';

abstract class JsonRepository {
  Future<DataAndPlots> getDataAndPlots();
  Future<Datum> getDatum();
  StreamController<DataAndPlots> get eventStream;
  List getSeriesByName(String name);
  Future<List<Plot>> getPlots();
}
