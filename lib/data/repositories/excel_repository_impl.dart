import 'package:dartz/dartz.dart';
import 'package:excel/excel.dart';
import 'package:flutter_dashboard/common/errors/exceptions.dart';
import 'package:flutter_dashboard/common/errors/failures.dart';
import 'package:flutter_dashboard/data/datasources/excel_local.dart';
import 'package:flutter_dashboard/domain/repositories/excel_repository.dart';

class ExcelRepositoryImpl extends ExcelRepository {
  final EcxelLocalData localDataSource;

  ExcelRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, Map<String, Sheet>>> getAllTablesFrom(
      String path) async {
    try {
      var excel = await localDataSource.loadExcelByPath(path);
      return Right(excel.tables);
    } on FileException {
      return Left(FileFailure());
    }
  }

  @override
  Future<Either<Failure, Sheet>> getTableByName(
      String sheetName, Map<String, Sheet> tables) async {
    if (tables.containsKey(sheetName)) {
      return Right(tables[sheetName]!);
    }
    return Left(FileFailure());
  }
}
