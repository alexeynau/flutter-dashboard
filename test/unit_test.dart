// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/docs/cookbook/testing/unit/introduction

import 'package:excel/excel.dart';
import 'package:flutter_dashboard/data/datasources/excel_local.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  EcxelLocalData localData = ExcelLocalDataImpl();
  group('Excel', () {
    test('Read', () async {
      var excel = await localData.loadExcelByPath(
          'C:/Users/user/Downloads/Telegram Desktop/test.xlsx');
      expect(excel.tables.isNotEmpty, true);
    });
  });
}
