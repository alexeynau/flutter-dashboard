import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/domain/repositories/json_repository.dart';

part 'selector_event.dart';
part 'selector_state.dart';

class SelectorBloc extends Bloc<SelectorEvent, SelectorState> {
  SelectorBloc() : super(SelectorInitial()) {
    on<ChangeSelected>((event, emit) {
      _changeSelected(event, emit);
    });
    on<AddValue>((event, emit) {
      _addValue(event, emit);
    });
    on<RemoveValue>((event, emit) {
      _removeValue(event, emit);
    });
  }

  void _addValue(AddValue event, Emitter<SelectorState> emit) async {
    // emit(SelectorLoading());
    if (state is SelectorLoaded) {
      List<String> chosenY = (state as SelectorLoaded).chosenY.toList();
      chosenY.add(event.name);

      print("add");
      print(chosenY);
      emit(SelectorLoaded((state as SelectorLoaded).allY, chosenY));
    }
  }

  void _removeValue(RemoveValue event, Emitter<SelectorState> emit) async {
    // emit(SelectorLoading());
    if (state is SelectorLoaded) {
      List<String> chosenY = (state as SelectorLoaded).chosenY.toList();
      chosenY.remove(event.name);

      print("add");
      print(chosenY);
      emit(SelectorLoaded((state as SelectorLoaded).allY, chosenY));
    }
  }

  void _changeSelected(
      ChangeSelected event, Emitter<SelectorState> emit) async {
    emit(SelectorLoading());
    emit(SelectorLoaded(event.allY, event.chosenY));
  }
}
