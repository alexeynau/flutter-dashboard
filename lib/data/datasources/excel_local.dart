import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter_dashboard/common/errors/exceptions.dart';

abstract class ExcelLocalData {
  Future<Excel> loadExcelByPath(String path);
}

class ExcelLocalDataImpl implements ExcelLocalData {
  /// Read excel file by path given in params and returns Excel file
  ///
  /// Throws [FileException] when file not found
  @override
  Future<Excel> loadExcelByPath(String path) async {
    var file = File(path);
    if (await file.exists()) {
      // should be sync?
      var bytes = await file.readAsBytes();
      var excel = Excel.decodeBytes(bytes);

      // for (var table in excel.tables.keys) {
      //   print(table); //sheet Name
      //   print(excel.tables[table]?.maxCols);
      //   print(excel.tables[table]?.maxRows);
      //   for (var row in excel.tables[table]!.rows) {
      //     print('$row');
      //   }
      // }
      return excel;
    } else {
      throw FileException("File Not Found");
    }
  }
}
