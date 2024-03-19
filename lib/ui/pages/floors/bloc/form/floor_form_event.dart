part of 'floor_form_bloc.dart';

@immutable
abstract class FloorFormEvent extends Equatable {
  const FloorFormEvent();
}

class AddFloorEvent extends FloorFormEvent {
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
  List<Object?> get props => [token, propertyId, floorName, description];
}
