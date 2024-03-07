

abstract class PropertyRepo {
  Future<dynamic> getALlProperties(String token);

  Future<dynamic> getSingleProperty(int id, String token);

  Future<dynamic> addProperty(
      String token,
      String name,
      String location,
      String sqm,
      String description,
      int propertyTypeId,
      int propertyCategoryId);
}
