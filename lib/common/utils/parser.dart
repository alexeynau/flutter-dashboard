import 'package:excel/excel.dart';

List<String?> fromDataToValue(List<Data?> list) {
  final List<String?> res = [];
  list.forEach((element) {
    res.add(element?.value.toString());
  });
  return res;
}
