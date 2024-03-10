// To parse this JSON data, do
//
//     final paymentsModel = paymentsModelFromJson(jsonString);

import 'dart:convert';

List<List<PaymentsModel>> paymentsModelFromJson(String str) => List<List<PaymentsModel>>.from(json.decode(str).map((x) => List<PaymentsModel>.from(x.map((x) => PaymentsModel.fromJson(x)))));

String paymentsModelToJson(List<List<PaymentsModel>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class PaymentsModel {
  int? id;
  DateTime? date;
  int? amount;
  int? amountDue;
  int? propertyId;
  int? accountId;
  int? paymentModeId;
  int? tenantUnitId;
  dynamic description;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  Property? property;

  PaymentsModel({
    this.id,
    this.date,
    this.amount,
    this.amountDue,
    this.propertyId,
    this.accountId,
    this.paymentModeId,
    this.tenantUnitId,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.property,
  });

  factory PaymentsModel.fromJson(Map<String, dynamic> json) => PaymentsModel(
    id: json["id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    amount: json["amount"],
    amountDue: json["amount_due"],
    propertyId: json["property_id"],
    accountId: json["account_id"],
    paymentModeId: json["payment_mode_id"],
    tenantUnitId: json["tenant_unit_id"],
    description: json["description"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    property: json["property"] == null ? null : Property.fromJson(json["property"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "amount": amount,
    "amount_due": amountDue,
    "property_id": propertyId,
    "account_id": accountId,
    "payment_mode_id": paymentModeId,
    "tenant_unit_id": tenantUnitId,
    "description": description,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "property": property?.toJson(),
  };
}

class Property {
  int? id;
  String? name;
  String? number;
  String? location;
  String? squareMeters;
  dynamic description;
  int? propertyTypeId;
  int? propertyCategoryId;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Property({
    this.id,
    this.name,
    this.number,
    this.location,
    this.squareMeters,
    this.description,
    this.propertyTypeId,
    this.propertyCategoryId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    id: json["id"],
    name: json["name"],
    number: json["number"],
    location: json["location"],
    squareMeters: json["square_meters"],
    description: json["description"],
    propertyTypeId: json["property_type_id"],
    propertyCategoryId: json["property_category_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "number": number,
    "location": location,
    "square_meters": squareMeters,
    "description": description,
    "property_type_id": propertyTypeId,
    "property_category_id": propertyCategoryId,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
