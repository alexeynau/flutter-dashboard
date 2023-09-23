import 'package:flutter_dashboard/domain/entities/series.dart';

class SeriesModel extends Series {
  SeriesModel({
    super.name,
    required super.data,
    super.index,
  });

  @override
  String toString() {
    return "$name \n $data";
  }
}
