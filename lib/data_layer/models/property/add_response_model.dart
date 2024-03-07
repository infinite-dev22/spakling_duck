// To parse this JSON data, do
//
//     final addPropertyResponseModel = addPropertyResponseModelFromJson(jsonString);

import 'dart:convert';

AddPropertyResponseModel addPropertyResponseModelFromJson(String str) =>
    AddPropertyResponseModel.fromJson(json.decode(str));

String addPropertyResponseModelToJson(AddPropertyResponseModel data) =>
    json.encode(data.toJson());

class AddPropertyResponseModel {
  PropertyCreatedViaApi? propertyCreatedViaApi;

  AddPropertyResponseModel({
    this.propertyCreatedViaApi,
  });

  factory AddPropertyResponseModel.fromJson(Map<String, dynamic> json) =>
      AddPropertyResponseModel(
        propertyCreatedViaApi: json["propertyCreatedViaApi"] == null
            ? null
            : PropertyCreatedViaApi.fromJson(json["propertyCreatedViaApi"]),
      );

  Map<String, dynamic> toJson() => {
        "propertyCreatedViaApi": propertyCreatedViaApi?.toJson(),
      };
}

class PropertyCreatedViaApi {
  String? number;
  String? name;
  String? location;
  String? squareMeters;
  String? description;
  int? propertyTypeId;
  int? propertyCategoryId;
  int? createdBy;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  PropertyCreatedViaApi({
    this.number,
    this.name,
    this.location,
    this.squareMeters,
    this.description,
    this.propertyTypeId,
    this.propertyCategoryId,
    this.createdBy,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory PropertyCreatedViaApi.fromJson(Map<String, dynamic> json) =>
      PropertyCreatedViaApi(
        number: json["number"],
        name: json["name"],
        location: json["location"],
        squareMeters: json["square_meters"],
        description: json["description"],
        propertyTypeId: json["property_type_id"],
        propertyCategoryId: json["property_category_id"],
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
        "number": number,
        "name": name,
        "location": location,
        "square_meters": squareMeters,
        "description": description,
        "property_type_id": propertyTypeId,
        "property_category_id": propertyCategoryId,
        "created_by": createdBy,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
