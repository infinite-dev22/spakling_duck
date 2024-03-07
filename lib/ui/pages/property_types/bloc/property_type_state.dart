part of 'property_type_bloc.dart';

enum PropertyTypeStatus {
  initial,
  success,
  loading,
  accessDenied,
  error,
  empty
}

@immutable
class PropertyTypeState extends Equatable {
  final List<PropertyTypeModel>? propertyTypes;
  final PropertyTypeStatus? status;

  const PropertyTypeState(
      {this.propertyTypes, this.status = PropertyTypeStatus.initial});

  @override
  // TODO: implement props
  List<Object?> get props => [propertyTypes, status];

  PropertyTypeState copyWith({
    final List<PropertyTypeModel>? propertyTypes,
    final PropertyTypeStatus? status,
  }) {
    return PropertyTypeState(
      propertyTypes: propertyTypes ?? this.propertyTypes,
      status: status ?? this.status,
    );
  }
}

@immutable
class PropertyTypeInitial extends PropertyTypeState {
  @override
  List<Object> get props => [];
}
