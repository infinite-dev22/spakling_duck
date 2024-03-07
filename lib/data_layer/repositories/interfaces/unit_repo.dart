abstract class UnitRepo {
  Future<dynamic> getALlUnits(String token, int id);

  Future<dynamic> getUnitTypes(String token, int id);

  Future<dynamic> addUnitToProperty(String token, int unitTypeId, int floorId, String name, String sqm,
      int periodId, int currencyId, int initialAmount, String description, int propertyId);

}
