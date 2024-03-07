part of 'property_bloc.dart';

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

class AddPropertyEvent extends PropertyEvent {
  final String token;
  final String name;
  final String location;
  final String sqm;
  final String description;
  final int propertyTypeId;
  final int propertyCategoryId;

  const AddPropertyEvent(this.token, this.name, this.location, this.sqm,
      this.description, this.propertyTypeId, this.propertyCategoryId);

  @override
  List<Object?> get props => [
        token,
        name,
        location,
        sqm,
        description,
        propertyTypeId,
        propertyCategoryId
      ];
}

class PropertyAddedEvent extends PropertyEvent {}
