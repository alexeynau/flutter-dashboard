// import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dashboard/data/models/data.dart';
import 'package:flutter_dashboard/domain/repositories/json_repository.dart';

part 'chart_event.dart';
part 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  JsonRepository repository;
  ChartBloc({required this.repository}) : super(ChartInitial()) {
    on<LoadChart>((event, emit) {
      _loadChart(event, emit);
    });
  }

  void _loadChart(LoadChart event, Emitter<ChartState> emit) async {
    emit(ChartLoading());

    final data = await repository.getDataAndPlots();
    final plot = event.plot;

    if (data == null) {
      emit(ChartError());
      return;
    }

    emit(ChartLoaded(name: plot.name, xs: plot.x, ys: plot.y));
  }
}
