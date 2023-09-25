part of 'chart_bloc.dart';

sealed class ChartState extends Equatable {
  ChartState();

  @override
  List<Object> get props => [];
}

final class ChartInitial extends ChartState {}

final class ChartLoading extends ChartState {}

final class ChartLoaded extends ChartState {
  final String name;
  final String xs;
  final List<String> ys;

  ChartLoaded({
    required this.name,
    required this.xs,
    required this.ys,
  });

  @override
  List<Object> get props => [name, xs, ys];
}

final class ChartError extends ChartState {}
