import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dashboard/domain/repositories/json_repository.dart';
import 'package:flutter_dashboard/service_locator.dart';

part 'canvas_event.dart';
part 'canvas_state.dart';

class CanvasBloc extends Bloc<CanvasEvent, CanvasState> {
  CanvasBloc() : super(CanvasInitial()) {
    on<LoadCanvas>((event, emit) {
      // TODO: implement event handler
    });
  }

  void _loadCanvas(LoadCanvas event, Emitter<CanvasState> emit) async {
    emit(CanvasLoading());
    if (state.runtimeType is! CanvasLoaded) {
      print("data");
      var data = await (getIt<JsonRepository>()).getDataAndPlots();
      if (data.charts.plots.isNotEmpty) {
        emit(CanvasLoaded());
      } else {
        _loadCanvas(event, emit);
      }
    }
  }
}
