import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';
import 'package:flutter_dashboard/common/errors/failures.dart';
import 'package:flutter_dashboard/domain/repositories/excel_repository.dart';
import 'package:flutter_dashboard/domain/usecases/usecase.dart';

class GetTableByName extends UseCase<Sheet, GetTableByNameParams> {
  final ExcelRepository excelRepository;

  GetTableByName(this.excelRepository);

  @override
  Future<Either<Failure, Sheet>> call(GetTableByNameParams params) async {
    return await excelRepository.getTableByName(
        params.sheetName, params.tables);
  }
}

class GetTableByNameParams extends Equatable {
  const GetTableByNameParams(this.sheetName, this.tables);

  final String sheetName;
  final Map<String, Sheet> tables;

  @override
  List<Object?> get props => [sheetName, tables];
}
