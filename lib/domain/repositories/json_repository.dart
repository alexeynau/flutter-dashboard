import 'package:flutter_dashboard/data/models/data.dart';

abstract class JsonRepository {
  Future<DataAndPlots> getDataAndPlots();
  Future<Datum> getDatum();
}
