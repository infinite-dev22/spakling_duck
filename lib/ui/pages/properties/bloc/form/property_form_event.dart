part of 'property_form_bloc.dart';

@immutable
class PropertyFormEvent extends Equatable {
  const PropertyFormEvent();

  @override
  List<Object?> get props => [];
}

class LoadPropertiesEvent extends PropertyFormEvent {}

class LoadSinglePropertyFormEvent extends PropertyFormEvent {
  final int id;

  const LoadSinglePropertyFormEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddPropertyEvent extends PropertyFormEvent {
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

class PropertyAddedEvent extends PropertyFormEvent {}
