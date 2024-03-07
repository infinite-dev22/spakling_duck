// To parse this JSON data, do
//
//     final addUnitResponse = addUnitResponseFromJson(jsonString);

import 'dart:convert';

AddUnitResponse addUnitResponseFromJson(String str) => AddUnitResponse.fromJson(json.decode(str));

String addUnitResponseToJson(AddUnitResponse data) => json.encode(data.toJson());

class AddUnitResponse {
  UnitApi? unitApi;

  AddUnitResponse({
    this.unitApi,
  });

  factory AddUnitResponse.fromJson(Map<String, dynamic> json) => AddUnitResponse(
    unitApi: json["unitApi"] == null ? null : UnitApi.fromJson(json["unitApi"]),
  );

  Map<String, dynamic> toJson() => {
    "unitApi": unitApi?.toJson(),
  };
}

class UnitApi {
  String? name;
  String? amount;
  int? floorId;
  int? scheduleId;
  int? propertyId;
  int? currencyId;
  String? squareMeters;
  int? unitType;
  String? description;
  int? createdBy;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  UnitApi({
    this.name,
    this.amount,
    this.floorId,
    this.scheduleId,
    this.propertyId,
    this.currencyId,
    this.squareMeters,
    this.unitType,
    this.description,
    this.createdBy,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory UnitApi.fromJson(Map<String, dynamic> json) => UnitApi(
    name: json["name"],
    amount: json["amount"],
    floorId: json["floor_id"],
    scheduleId: json["schedule_id"],
    propertyId: json["property_id"],
    currencyId: json["currency_id"],
    squareMeters: json["square_meters"],
    unitType: json["unit_type"],
    description: json["description"],
    createdBy: json["created_by"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "amount": amount,
    "floor_id": floorId,
    "schedule_id": scheduleId,
    "property_id": propertyId,
    "currency_id": currencyId,
    "square_meters": squareMeters,
    "unit_type": unitType,
    "description": description,
    "created_by": createdBy,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
