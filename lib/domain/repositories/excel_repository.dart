import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:flutter_dashboard/common/errors/failures.dart';

abstract class ExcelRepository {
  Future<Either<Failure, Map<String, Sheet>>> getAllTablesFrom(String path);
  Future<Either<Failure, Sheet>> getTableByName(
      String sheetName, Map<String, Sheet> tables);
}
