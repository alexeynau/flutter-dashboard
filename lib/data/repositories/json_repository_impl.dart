import 'package:flutter_dashboard/data/models/data.dart';
import 'package:flutter_dashboard/domain/repositories/json_repository.dart';

import '../datasources/json_http.dart';

class JsonRepositoryImpl implements JsonRepository {
  final JsonRemoteData remoteDataSource;

  JsonRepositoryImpl(this.remoteDataSource);

  @override
  Future<Datum> getDatum() {
    // TODO: implement getDatum
    throw UnimplementedError();
  }

  @override
  Future<DataAndPlots> getDataAndPlots() {
    return remoteDataSource.loadJson();
  }
}
