import 'dart:async';

import 'package:flutter_dashboard/data/models/data.dart';
import 'package:flutter_dashboard/domain/repositories/json_repository.dart';

import '../datasources/json_http.dart';
import '../models/event_model.dart';

class JsonRepositoryImpl implements JsonRepository {
  final JsonRemoteData remoteDataSource;

  JsonRepositoryImpl(this.remoteDataSource);

  @override
  Future<Datum> getDatum() {
    // TODO: implement getDatum
    throw UnimplementedError();
  }

  StreamController<StreamEvent> get eventStream => remoteDataSource.eventStream;

  @override
  Future<DataAndPlots> getDataAndPlots() {
    return remoteDataSource.loadJson();
  }

  @override
  List getSeriesByName(String name) {
    return remoteDataSource
        .getData()
        .firstWhere((element) => element.name == name)
        .series;
  }
}
