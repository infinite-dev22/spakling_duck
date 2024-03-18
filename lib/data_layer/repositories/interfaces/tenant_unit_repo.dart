abstract class TenantUnitRepo {
  Future<dynamic> getALlTenantUnits(String token, int id);

  Future<dynamic> addTenantUnit(
      String token,
      int tenantId,
      int unitId,
      int periodId,
      String duration,
      String fromDate,
      String toDate,
      String unitAmount,
      int currencyId,
      String agreedAmount,
      String description,
      int propertyId);

  Future<dynamic> getALlTenantUnitSchedules(String token, int id);

}

