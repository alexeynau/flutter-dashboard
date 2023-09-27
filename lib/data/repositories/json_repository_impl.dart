import 'dart:async';

import 'package:flutter_dashboard/data/models/data.dart';
import 'package:flutter_dashboard/domain/repositories/json_repository.dart';

import '../datasources/json_http.dart';
// import '../models/event_model.dart';

class JsonRepositoryImpl implements JsonRepository {
  final JsonRemoteData remoteDataSource;
  JsonRepositoryImpl(this.remoteDataSource);

  late DataAndPlots dataAndPlots;
  @override
  Future<Datum> getDatum() {
    // TODO: implement getDatum
    throw UnimplementedError();
  }

  StreamController<DataAndPlots> get eventStream =>
      remoteDataSource.eventStream;

  @override
  Future<DataAndPlots> getDataAndPlots() async {
    dataAndPlots = await remoteDataSource.loadJson();
    return await remoteDataSource.loadJson();
  }

  @override
  List getSeriesByName(String name) {
    return remoteDataSource
        .getData()
        .firstWhere((element) => element.name == name)
        .series;
  }

  // @override
  // Future<List<Plot>> getPlots() async {
  //   return (await remoteDataSource.getCharts()).plots;
  // }
}
