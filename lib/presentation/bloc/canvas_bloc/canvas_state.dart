part of 'canvas_bloc.dart';

sealed class CanvasState extends Equatable {
  const CanvasState();

  @override
  List<Object> get props => [];
}

final class CanvasInitial extends CanvasState {}

final class CanvasLoading extends CanvasState {}

final class CanvasLoaded extends CanvasState {}
