abstract class FloorRepo {
  Future<dynamic> getALlFloors(String token, int id);

  Future<dynamic> addFloor(
      String token, int propertyId, String floorName, String? description);
}
