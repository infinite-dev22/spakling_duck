part of 'property_form_bloc.dart';

enum PropertyFormStatus {
  initial,
  success,
  loading,
  accessDenied,
  error,
  empty,
  notFound,
  loadingDetails,
  successDetails,
  errorDetails,
  emptyDetails,
  loadingAdd,
  errorAdd,
  emptyAdd,
  successAdd,
  accessDeniedAdd,
}

extension PropertyFormStatusX on PropertyFormStatus {
  bool get isInitial => this == PropertyFormStatus.initial;

  bool get isSuccess => this == PropertyFormStatus.success;

  bool get isError => this == PropertyFormStatus.error;

  bool get isLoading => this == PropertyFormStatus.loading;

  bool get isEmpty => this == PropertyFormStatus.empty;

  bool get isNotFound => this == PropertyFormStatus.notFound;
}

@immutable
class PropertyFormState extends Equatable {
  final List<Property>? properties;
  final PropertyFormStatus status;
  final Property? property;
  final bool? isPropertyLoading;
  final String? message;
  final AddPropertyResponseModel? addPropertyResponseModel;

  const PropertyFormState(
      {this.properties,
      this.status = PropertyFormStatus.initial,
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

  PropertyFormState copyWith({
    List<Property>? properties,
    PropertyFormStatus? status,
    Property? property,
    bool? isPropertyLoading,
    String? message,
    AddPropertyResponseModel? addPropertyResponseModel,
  }) {
    return PropertyFormState(
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
