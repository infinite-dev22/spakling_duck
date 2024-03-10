// To parse this JSON data, do
//
//     final addTenantUnitResponse = addTenantUnitResponseFromJson(jsonString);

import 'dart:convert';

AddTenantUnitResponse addTenantUnitResponseFromJson(String str) =>
    AddTenantUnitResponse.fromJson(json.decode(str));

String addTenantUnitResponseToJson(AddTenantUnitResponse data) =>
    json.encode(data.toJson());

class AddTenantUnitResponse {
  Tenantunitcreated? tenantunitcreated;
  String? message;

  AddTenantUnitResponse({
    this.tenantunitcreated,
    this.message
  });

  factory AddTenantUnitResponse.fromJson(Map<String, dynamic> json) =>
      AddTenantUnitResponse(
        tenantunitcreated: json["tenantunitcreated"] == null
            ? null
            : Tenantunitcreated.fromJson(json["tenantunitcreated"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "tenantunitcreated": tenantunitcreated?.toJson(),
        "message": message,
      };
}

class Tenantunitcreated {
  DateTime? fromDate;
  DateTime? toDate;
  String? amount;
  String? discountAmount;
  String? description;
  int? unitId;
  int? tenantId;
  int? currencyId;
  int? scheduleId;
  int? propertyId;
  int? createdBy;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Tenantunitcreated({
    this.fromDate,
    this.toDate,
    this.amount,
    this.discountAmount,
    this.description,
    this.unitId,
    this.tenantId,
    this.currencyId,
    this.scheduleId,
    this.propertyId,
    this.createdBy,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Tenantunitcreated.fromJson(Map<String, dynamic> json) =>
      Tenantunitcreated(
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        amount: json["amount"],
        discountAmount: json["discount_amount"],
        description: json["description"],
        unitId: json["unit_id"],
        tenantId: json["tenant_id"],
        currencyId: json["currency_id"],
        scheduleId: json["schedule_id"],
        propertyId: json["property_id"],
        createdBy: json["created_by"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "from_date": fromDate?.toIso8601String(),
        "to_date": toDate?.toIso8601String(),
        "amount": amount,
        "discount_amount": discountAmount,
        "description": description,
        "unit_id": unitId,
        "tenant_id": tenantId,
        "currency_id": currencyId,
        "schedule_id": scheduleId,
        "property_id": propertyId,
        "created_by": createdBy,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
