// import 'package:flutter_dashboard/data/datasources/excel_local.dart';
// import 'package:flutter_dashboard/data/repositories/excel_repository_impl.dart';
// import 'package:flutter_dashboard/domain/repositories/excel_repository.dart';
// import 'package:flutter_dashboard/domain/usecases/get_table_by_name.dart';
// import 'package:flutter_dashboard/data/datasources/json_local.dart';
import 'package:flutter_dashboard/data/repositories/json_repository_impl.dart';
import 'package:flutter_dashboard/domain/repositories/json_repository.dart';
// import 'package:flutter_dashboard/presentation/bloc/chart_bloc/chart_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/json_http.dart';
import 'data/repositories/windows_repository.dart';
// import 'presentation/bloc/bloc/selector_bloc.dart';
// import 'presentation/bloc/canvas_bloc/canvas_bloc.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  // Usecases
  // getIt.registerLazySingleton(() => GetTableByName(getIt()));

  // getIt.registerLazySingleton<ExcelRepository>(
  //   () => ExcelRepositoryImpl(
  //     localDataSource: getIt(),
  //   ),
  // );

  getIt.registerLazySingleton<WindowsRepository>(() => WindowsRepository());
  // getIt.registerFactory(() => ChartBloc(repository: getIt()));
  // getIt.registerFactory(() => SelectorBloc());
  // getIt.registerFactory(() => CanvasBloc());
  // getIt.registerLazySingleton<ExcelLocalData>(() => ExcelLocalDataImpl());
  // getIt.registerLazySingleton<JsonLocalData>(() => JsonLocalDataImpl());
  getIt.registerLazySingleton<JsonRemoteData>(() => JsonRemoteDataImpl());
  getIt.registerLazySingleton<JsonRepository>(
    () => JsonRepositoryImpl(
      getIt(),
    ),
  );
}
