abstract class SmartModel {
  int getId();

  String getName();
}

abstract class SmartTenantTypeModel {
  int getId();

  String getName();
}

abstract class SmartUnitModel {
  int getId();

  String getUnitNumber();

  String getUnitName();

  int getFloorId();

  String getDescription();

  int getPeriodId();

  int getAmount();

  int getUnitType();

  int getAvailability();

  int getPropertyId();
}

abstract class SmartSalutationModel {
  int getId();

  String getName();
}

abstract class SmartFloorModel {
  int getId();

  String getName();
}

abstract class SmartCurrencyModel {
  int getId();

  String getCurrency();
}

abstract class SmartNationalityModel {
  int getId();

  // String getCurrency();
  String getCountry();
// String getCode();
// String getSymbol();
}

abstract class SmartPeriodModel {
  int getId();

  String getName();

  int getPeriod();
}

abstract class SmartTenantModel {
  int getId();

  String getName();

  int getTenantTypeId();

  int getNationId();

  String getTenantNo();

  int getBusinessTypeId();

  String getDescription();

  String getImageDocUrl();

  String getBusinessType();

  String getTenantType();
}

abstract class SmartTenantUnitModel {
  int getId();

  int getTenantId();

  int getUnitId();

  int getAmount();

  int getDiscount();
}

abstract class SmartTenantUnitsModel {
  int getId();

  int getTenantId();

  int getUnitId();

  int getAmount();

  int getDiscount();

  String getTenantName();

  String getUnitName();
}

abstract class SmartTenantUnitScheduleModel {
  int getId();

  String getTenantName();

  String getUnitNumber();

  int getBalance();

  int getPaid();

  int getAmount();

  int getTenantId();

  int getUnitId();

  DateTime getFromDate();

  DateTime getToDate();
}

abstract class SmartSpecificTenantUnitModel {
  int getId();

  String getUnitNumber();

  String getTenantName();

  int getAmount();

  int getTenantId();

  int getUnitId();

  int getPropertyId();

  DateTime getFromDate();

  DateTime getToDate();
}

abstract class SmartUserRoleModel {
  int getId();

  String getName();

  String getDescription();
}

// int? id;
// String? name;
// String? description;
// int? organisationId;
// String? squareMeters;
// int? propertyTypeId;
// int? categoryTypeId;
// String? location;

abstract class SmartPropertyModel {
  int getId();

  String getName();

  String getDescription();

  int getOrganisationId();

  int getPropertyTypeId();

  int getCategoryTypeId();

  String getLocation();

  String getSquareMeters();

  int getMainImage();

  String getImageDocUrl();

  String getNumber();

  String getPropertyCategoryName();
}

abstract class SmartEmployeePropertyModel {
  int getId();

  String getUserId();

  int getRoleId();

  int getOrganizationId();

  int getPropertyId();

  String getPropertyName();

  String getPropertyLocation();
}

abstract class SmartPropertyUnitModel {
  int getId();

  int getPropertyId();

  int getTotalUnits();

  int getAvailableUnits();

  int getOccupiedUnits();

  int getRevenue();
}
