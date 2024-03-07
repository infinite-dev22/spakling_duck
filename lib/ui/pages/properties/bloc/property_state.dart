part of 'property_bloc.dart';

enum PropertyStatus {
  initial,
  success,
  loading,
  accessDenied,
  error,
  empty,
  loadingDetails,
  successDetails,
  errorDetails,
  emptyDetails,
  loadingAdd,
  errorAdd,
  emptyAdd,
  successAdd,
  accessDeniedAdd,
  refreshListSuccess
}

@immutable
class PropertyState extends Equatable {
  final List<Property>? properties;
  final PropertyStatus? status;
  final Property? property;
  final bool? isPropertyLoading;
  final String? message;
  final AddPropertyResponseModel? addPropertyResponseModel;

  const PropertyState(
      {this.properties,
      this.status = PropertyStatus.initial,
      this.property,
      this.isPropertyLoading = false,
      this.message = '',
      this.addPropertyResponseModel});

  @override
  // TODO: implement props
  List<Object?> get props => [
        properties,
        status,
        property,
        isPropertyLoading,
        message,
        addPropertyResponseModel
      ];

  PropertyState copyWith({
    List<Property>? properties,
    PropertyStatus? status,
    Property? property,
    bool? isPropertyLoading,
    String? message,
    AddPropertyResponseModel? addPropertyResponseModel,
  }) {
    return PropertyState(
      properties: properties ?? this.properties,
      status: status ?? this.status,
      property: property ?? this.property,
      isPropertyLoading: isPropertyLoading ?? this.isPropertyLoading,
      message: message ?? this.message,
      addPropertyResponseModel:
          addPropertyResponseModel ?? this.addPropertyResponseModel,
    );
  }
}

class PropertyInitial extends PropertyState {
  @override
  List<Object> get props => [];
}
