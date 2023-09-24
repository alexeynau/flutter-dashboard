// import 'package:flutter_dashboard/data/datasources/excel_local.dart';
// import 'package:flutter_dashboard/data/repositories/excel_repository_impl.dart';
// import 'package:flutter_dashboard/domain/repositories/excel_repository.dart';
// import 'package:flutter_dashboard/domain/usecases/get_table_by_name.dart';
import 'package:flutter_dashboard/data/datasources/json_local.dart';
import 'package:flutter_dashboard/data/repositories/json_repository_impl.dart';
import 'package:flutter_dashboard/domain/repositories/json_repository.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/json_http.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  // Usecases
  // getIt.registerLazySingleton(() => GetTableByName(getIt()));

  // getIt.registerLazySingleton<ExcelRepository>(
  //   () => ExcelRepositoryImpl(
  //     localDataSource: getIt(),
  //   ),
  // );

  // getIt.registerLazySingleton<ExcelLocalData>(() => ExcelLocalDataImpl());
  getIt.registerLazySingleton<JsonLocalData>(() => JsonLocalDataImpl());
  getIt.registerLazySingleton<JsonRemoteData>(() => JsonRemoteDataImpl());
  getIt.registerLazySingleton<JsonRepository>(
    () => JsonRepositoryImpl(
      getIt(),
    ),
  );
}
