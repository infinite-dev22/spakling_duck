part of 'unit_form_bloc.dart';

enum UnitFormStatus {
  initial,
  success,
  loading,
  reLoading,
  reLoaded,
  accessDenied,
  error,
  empty,
  successUT,
  loadingUT,
  accessDeniedUT,
  errorUT,
  emptyUT,
}

extension UnitFormStatusX on UnitFormStatus {
  bool get isInitial => this == UnitFormStatus.initial;

  bool get isLoading => this == UnitFormStatus.loading;

  bool get isSuccess => this == UnitFormStatus.success;

  bool get isError => this == UnitFormStatus.error;

  bool get isEmpty => this == UnitFormStatus.empty;

  bool get isReloaded => this == UnitFormStatus.reLoaded;

  bool get isReloading => this == UnitFormStatus.reLoading;

  bool get isAccessDenied => this == UnitFormStatus.accessDenied;
}

@immutable
class UnitFormState extends Equatable {
  final List<UnitModel> units;
  final UnitFormStatus status;
  final UnitModel? unitModel;
  final bool? isLoading;
  final List<UnitTypeModel>? unitTypes;
  final AddUnitResponse? addUnitResponse;
  final String? message;

  const UnitFormState(
      {List<UnitModel>? units,
      this.status = UnitFormStatus.initial,
      this.unitModel,
      this.isLoading = false,
      this.unitTypes,
      this.addUnitResponse,
      this.message = ''})
      : units = units ?? const [];

  UnitFormState copyWith({
    List<UnitModel>? units,
    UnitFormStatus? status,
    UnitModel? unitModel,
    bool? isLoading,
    List<UnitTypeModel>? unitTypes,
    AddUnitResponse? addUnitResponse,
    String? message,
  }) {
    return UnitFormState(
      units: units ?? this.units,
      status: status ?? this.status,
      unitModel: unitModel ?? this.unitModel,
      isLoading: isLoading ?? this.isLoading,
      unitTypes: unitTypes ?? this.unitTypes,
      addUnitResponse: addUnitResponse ?? this.addUnitResponse,
      message: message ?? this.message,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        units,
        status,
        unitModel,
        isLoading,
        unitTypes,
        addUnitResponse,
        message
      ];
}
