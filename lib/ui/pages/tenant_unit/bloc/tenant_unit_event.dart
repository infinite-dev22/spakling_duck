part of 'tenant_unit_bloc.dart';

abstract class TenantUnitEvent extends Equatable {
  const TenantUnitEvent();
}

class LoadTenantUnitsEvent extends TenantUnitEvent {
  final int id;

  const LoadTenantUnitsEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class LoadTenantUnitPaymentSchedules extends TenantUnitEvent {
  final int tenantUnitId;

  const LoadTenantUnitPaymentSchedules(this.tenantUnitId);

  @override
  List<Object?> get props => [tenantUnitId];
}

class RefreshTenantUnitsEvent extends TenantUnitEvent {
  final int id;

  const RefreshTenantUnitsEvent(this.id);

  @override
  List<Object?> get props => [id];
}