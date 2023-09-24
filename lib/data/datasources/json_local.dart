import 'package:flutter/services.dart';
import 'package:flutter_dashboard/data/models/data.dart';

abstract class JsonLocalData {
  Future<DataAndPlots> loadJsonFromAsset(String fileName);
}

class JsonLocalDataImpl implements JsonLocalData {
  @override
  Future<DataAndPlots> loadJsonFromAsset(String fileName) async {
    String textFromJson = await rootBundle.loadString("assets/json/$fileName");
    var data = dataAndPlotsFromJson(textFromJson);
    return data;
  }
}
