
import 'package:smart_rent/data_layer/models/tenant_unit/add_tenant_unit_response.dart';
import 'package:smart_rent/data_layer/repositories/implementation/tenant_unit_repo_impl.dart';
import 'package:smart_rent/data_layer/repositories/interfaces/tenant_unit_repo.dart';

class TenantUnitDtoImpl {
  static Future<AddTenantUnitResponse> addTenantUnit(
      String token, int tenantId, int unitId, int periodId, String fromDate,
      String toDate, String unitAmount, int currencyId, String agreedAmount, String description, int propertyId, {
        Function()? onSuccess,
        Function()? onError,
      }) async {
    print("In here");
    var result;
    TenantUnitRepo tenantUnitRepo = TenantUnitRepoImpl();
    await tenantUnitRepo
        .addTenantUnit(  token,  tenantId,  unitId,  periodId,  fromDate,
         toDate,  unitAmount,  currencyId,  agreedAmount,  description,  propertyId
    ).then((response) => result = AddTenantUnitResponse.fromJson(response));
    print("Then here");

    return result;
  }
}
