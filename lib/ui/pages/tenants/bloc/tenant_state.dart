part of 'tenant_bloc.dart';

enum TenantStatus {
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
  successTT,
  loadingTT,
  accessDeniedTT,
  errorTT,
  emptyTT
}

@immutable
class TenantState extends Equatable {
  final List<TenantModel>? tenants;
  final TenantStatus status;
  final TenantDetailsModel? tenantModel;
  final bool? isLoading;
  final List<TenantTypeModel>? tenantTypes;

  const TenantState({
    this.tenants,
    this.status = TenantStatus.initial,
    this.tenantModel,
    this.isLoading = false,
    this.tenantTypes,
  });

  TenantState copyWith({
    List<TenantModel>? tenants,
    TenantStatus? status,
    TenantDetailsModel? tenantModel,
    bool? isLoading,
    List<TenantTypeModel>? tenantTypes,
  }) {
    return TenantState(
      tenants: tenants ?? this.tenants,
      status: status ?? this.status,
      tenantModel: tenantModel ?? this.tenantModel,
      isLoading: isLoading ?? this.isLoading,
      tenantTypes: tenantTypes ?? this.tenantTypes,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [tenants, status, tenantModel, isLoading, tenantTypes];
}

class TenantInitial extends TenantState {
  @override
  List<Object> get props => [];
}
