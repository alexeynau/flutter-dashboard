import 'package:flutter/services.dart';
import 'package:flutter_dashboard/data/models/data.dart';
import 'package:http/http.dart' as http;

abstract class JsonRemoteData {
  Future<DataAndPlots> loadJson();
}

class JsonRemoteDataImpl implements JsonRemoteData {
  @override
  Future<DataAndPlots> loadJson() async {
    String url = "http://localhost:8000/";
    var response = await http.get(Uri.parse(url));
    print("got response");
    print(response.body);
    String resBody = dataAndPlotsToJson(DataAndPlots(data: [], plots: []));
    if (response.statusCode == 200) {
      resBody = response.body;
    } else {
      print(response.statusCode);
    }

    return dataAndPlotsFromJson(resBody);
  }
}
