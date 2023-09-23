import 'package:excel/excel.dart';

List<dynamic> fromDataToValue(List<Data?> list) {
  final List<dynamic> res = [];
  list.forEach((element) {
    res.add(element?.value);
  });
  return res;
}
