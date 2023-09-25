part of 'canvas_bloc.dart';

sealed class CanvasEvent extends Equatable {
  const CanvasEvent();

  @override
  List<Object> get props => [];
}

class LoadCanvas extends CanvasEvent {}
