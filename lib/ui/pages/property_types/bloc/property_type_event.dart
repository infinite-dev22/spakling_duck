part of 'property_type_bloc.dart';

abstract class PropertyTypeEvent extends Equatable {
  const PropertyTypeEvent();
}

class LoadAllPropertyTypesEvent extends PropertyTypeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
