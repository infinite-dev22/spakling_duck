
import 'package:smart_rent/data_layer/models/floor/add_floor_response_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/floor_repo_impl.dart';
import 'package:smart_rent/data_layer/repositories/interfaces/floor_repo.dart';

class FloorDtoImpl {
  static Future<AddFloorResponseModel> addFloor(
    String token,
    int propertyId,
    String floorName,
    String? description, {
    Function()? onSuccess,
    Function()? onError,
  }) async {
    FloorRepo floorRepo = FloorRepoImpl();
    var result = await floorRepo
        .addFloor(token, propertyId, floorName, description)
        .then((response) => AddFloorResponseModel.fromJson(response));

    return result;
  }
}
