part of 'tenant_unit_form_bloc.dart';

enum TenantUnitFormStatus {
  initial,
  success,
  loading,
  accessDenied,
  error,
  empty,
}

extension TenantUnitFormStatusX on TenantUnitFormStatus {
  bool get isInitial => this == TenantUnitFormStatus.initial;

  bool get isLoading => this == TenantUnitFormStatus.loading;

  bool get isSuccess => this == TenantUnitFormStatus.success;

  bool get isError => this == TenantUnitFormStatus.error;

  bool get isEmpty => this == TenantUnitFormStatus.empty;

  bool get isAccessDenied => this == TenantUnitFormStatus.accessDenied;
}

@immutable
class TenantUnitFormState extends Equatable {
  final List<TenantUnitModel>? tenantUnits;
  final TenantUnitFormStatus status;
  final TenantUnitModel? tenantUnitModel;
  final bool? isLoading;
  final AddTenantUnitResponse? addTenantUnitResponse;
  final String? message;

  const TenantUnitFormState(
      {this.tenantUnits,
      this.status = TenantUnitFormStatus.initial,
      this.tenantUnitModel,
      this.isLoading = false,
      this.addTenantUnitResponse,
      this.message});

  TenantUnitFormState copyWith({
    List<TenantUnitModel>? tenantUnits,
    TenantUnitFormStatus? status,
    TenantUnitModel? tenantUnitModel,
    bool? isLoading,
    AddTenantUnitResponse? addTenantUnitResponse,
    String? message,
  }) {
    return TenantUnitFormState(
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

class TenantUnitInitial extends TenantUnitFormState {
  @override
  List<Object> get props => [];
}
