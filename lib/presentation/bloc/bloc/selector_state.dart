part of 'selector_bloc.dart';

sealed class SelectorState extends Equatable {
  const SelectorState();

  @override
  List<Object> get props => [];
}

final class SelectorInitial extends SelectorState {}

final class SelectorLoading extends SelectorState {}

final class SelectorLoaded extends SelectorState {
  final List<String> allY;
  final List<String> chosenY;

  const SelectorLoaded(this.allY, this.chosenY);

  @override
  List<Object> get props => [allY, chosenY];
}
