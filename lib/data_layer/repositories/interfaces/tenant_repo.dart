

abstract class TenantRepo {
  Future<dynamic> getALlTenants(String token);

  Future<dynamic> getSingleTenant(String token, int id);

  Future<dynamic> getALlTenantTypes(String token);
}
