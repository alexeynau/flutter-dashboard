part of 'selector_bloc.dart';

sealed class SelectorEvent extends Equatable {
  const SelectorEvent();

  @override
  List<Object> get props => [];
}

class ChangeSelected extends SelectorEvent {
  final List<String> allY;
  final List<String> chosenY;

  const ChangeSelected(this.allY, this.chosenY);
  @override
  List<Object> get props => [allY, chosenY];
}

class AddValue extends SelectorEvent {
  final String name;

  const AddValue(this.name);

  @override
  List<Object> get props => [name];
}

class RemoveValue extends SelectorEvent {
  final String name;

  const RemoveValue(this.name);

  @override
  List<Object> get props => [name];
}
