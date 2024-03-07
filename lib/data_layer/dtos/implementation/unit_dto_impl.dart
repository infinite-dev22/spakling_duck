import 'package:smart_rent/data_layer/repositories/implementation/unit_repo_impl.dart';
import 'package:smart_rent/data_layer/models/unit/add_unit_response.dart';
import 'package:smart_rent/data_layer/repositories/interfaces/unit_repo.dart';

class UnitDtoImpl {
  static Future<AddUnitResponse> addUnitToProperty(
      String token, int unitTypeId, int floorId, String name, String sqm,
      int periodId, int currencyId, int initialAmount, String description, int propertyId, {
        Function()? onSuccess,
        Function()? onError,
      }) async {
    UnitRepo unitRepo = UnitRepoImpl();
    var result = await unitRepo
        .addUnitToProperty(token, unitTypeId, floorId, name, sqm, periodId, currencyId, initialAmount,
      description, propertyId
    ).then((response) => AddUnitResponse.fromJson(response));

    return result;
  }
}
