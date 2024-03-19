part of 'property_bloc.dart';

@immutable
class PropertyEvent extends Equatable {
  const PropertyEvent();

  @override
  List<Object?> get props => [];
}

class LoadPropertiesEvent extends PropertyEvent {}

class RefreshPropertiesEvent extends PropertyEvent {}

class LoadSinglePropertyEvent extends PropertyEvent {
  final int id;

  const LoadSinglePropertyEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class PropertyAddedEvent extends PropertyEvent {}
