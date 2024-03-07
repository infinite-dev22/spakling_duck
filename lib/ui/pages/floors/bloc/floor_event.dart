part of 'floor_bloc.dart';

abstract class FloorEvent extends Equatable {
  const FloorEvent();
}

class LoadAllFloorsEvent extends FloorEvent {
  final int id;

  const LoadAllFloorsEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddFloorEvent extends FloorEvent {
  final String token;
  final int propertyId;
  final String floorName;
  final String description;

  const AddFloorEvent(
    this.token,
    this.propertyId,
    this.floorName,
    this.description,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [token, propertyId, floorName, description];
}
