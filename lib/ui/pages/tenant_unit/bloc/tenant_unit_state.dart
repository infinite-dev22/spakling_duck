part of 'tenant_unit_bloc.dart';

enum TenantUnitStatus {
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
  successAdd,
  loadingAdd,
  accessDeniedAdd,
  errorAdd,
  emptyAdd,
}

extension TenantUnitStatusX on TenantUnitStatus {
  bool get isInitial => this == TenantUnitStatus.initial;

  bool get isLoading => this == TenantUnitStatus.loading;

  bool get isSuccess => this == TenantUnitStatus.success;

  bool get isError => this == TenantUnitStatus.error;

  bool get isEmpty => this == TenantUnitStatus.empty;

  bool get isAccessDenied => this == TenantUnitStatus.accessDenied;

  bool get isSuccessAdd => this == TenantUnitStatus.successAdd;

  bool get isLoadingAdd => this == TenantUnitStatus.loadingAdd;

  bool get isAccessDeniedAdd => this == TenantUnitStatus.accessDeniedAdd;

  bool get isErrorAdd => this == TenantUnitStatus.errorAdd;

  bool get isEmptyAdd => this == TenantUnitStatus.emptyAdd;
}

@immutable
class TenantUnitState extends Equatable {
  final List<TenantUnitModel>? tenantUnits;
  final TenantUnitStatus status;
  final TenantUnitModel? tenantUnitModel;
  final bool? isLoading;
  final AddTenantUnitResponse? addTenantUnitResponse;
  final String? message;

  const TenantUnitState(
      {this.tenantUnits,
      this.status = TenantUnitStatus.initial,
      this.tenantUnitModel,
      this.isLoading = false,
      this.addTenantUnitResponse,
      this.message});

  TenantUnitState copyWith({
    List<TenantUnitModel>? tenantUnits,
    TenantUnitStatus? status,
    TenantUnitModel? tenantUnitModel,
    bool? isLoading,
    AddTenantUnitResponse? addTenantUnitResponse,
    String? message,
  }) {
    return TenantUnitState(
        tenantUnits: tenantUnits ?? this.tenantUnits,
        status: status ?? this.status,
        tenantUnitModel: tenantUnitModel ?? this.tenantUnitModel,
        isLoading: isLoading ?? this.isLoading,
        addTenantUnitResponse:
            addTenantUnitResponse ?? this.addTenantUnitResponse,
        message: message ?? this.message);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        tenantUnits,
        status,
        tenantUnitModel,
        isLoading,
        addTenantUnitResponse,
        message
      ];
}

class TenantUnitInitial extends TenantUnitState {
  @override
  List<Object> get props => [];
}
