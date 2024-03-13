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

class RefreshTenantUnitsEvent extends TenantUnitEvent {
  final int id;

  const RefreshTenantUnitsEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddTenantUnitEvent extends TenantUnitEvent {
  final String token;
  final int tenantId;
  final int unitId;
  final int periodId;
  final String fromDate;
  final String duration;
  final String toDate;
  final String unitAmount;
  final int currencyId;
  final String agreedAmount;
  final String description;
  final int propertyId;

      const AddTenantUnitEvent(
          this.token,
          this.tenantId,
          this.unitId,
          this.periodId,
          this.duration,
          this.fromDate,
          this.toDate,
          this.unitAmount,
          this.currencyId,
          this.agreedAmount,
          this.description,
          this.propertyId

          );

  @override
  List<Object?> get props => [token, tenantId, unitId, duration, periodId, fromDate, toDate, unitAmount, currencyId, agreedAmount, description, propertyId];

}