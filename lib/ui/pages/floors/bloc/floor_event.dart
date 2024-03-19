part of 'floor_bloc.dart';

@immutable
abstract class FloorEvent extends Equatable {
  const FloorEvent();
}

class LoadAllFloorsEvent extends FloorEvent {
  final int id;

  const LoadAllFloorsEvent(this.id);

  @override
  List<Object?> get props => [];
}
