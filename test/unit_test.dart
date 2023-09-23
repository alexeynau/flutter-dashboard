// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/docs/cookbook/testing/unit/introduction

import 'package:excel/excel.dart';
import 'package:flutter_dashboard/common/utils/parser.dart';
import 'package:flutter_dashboard/data/datasources/excel_local.dart';
import 'package:flutter_dashboard/data/repositories/excel_repository_impl.dart';
import 'package:flutter_dashboard/domain/repositories/excel_repository.dart';
import 'package:flutter_dashboard/domain/usecases/get_table_by_name.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  EcxelLocalData localData = ExcelLocalDataImpl();
  ExcelRepository repository = ExcelRepositoryImpl(localDataSource: localData);
  GetTableByName getTableByName = GetTableByName(repository);
  group('Excel', () {
    test('Read', () async {
      var excel = await repository.getAllTablesFrom(
          'C:/Users/user/Downloads/Telegram Desktop/test.xlsx');
      expect(excel.getOrElse(() => {}).isNotEmpty, true);
    });
    test('Read sheet', () async {
      var excel = await repository.getAllTablesFrom(
          'C:/Users/user/Downloads/Telegram Desktop/test.xlsx');
      var sheet = await getTableByName.call(
        GetTableByNameParams(
          "Company ABC_факт_НДПИ (Argus)",
          excel.getOrElse(() => {}),
        ),
      );
      var res = sheet.toOption().toNullable();
      expect(res is Sheet, true);
    });
    test('Sheet content', () async {
      var excel = await repository.getAllTablesFrom(
          'C:/Users/user/Downloads/Telegram Desktop/test.xlsx');
      var sheet = await getTableByName.call(
        GetTableByNameParams(
          "Company ABC_факт_НДПИ (Argus)",
          excel.getOrElse(() => {}),
        ),
      );
      var res = sheet.toOption().toNullable();
      if (res != null) {
        print(fromDataToValue(res.row(34)));
      }
      expect(res is Sheet, true);
    });
  });
}
