// To parse this JSON data, do
//
//     final addFloorResponseModel = addFloorResponseModelFromJson(jsonString);

import 'dart:convert';

AddFloorResponseModel addFloorResponseModelFromJson(String str) =>
    AddFloorResponseModel.fromJson(json.decode(str));

String addFloorResponseModelToJson(AddFloorResponseModel data) =>
    json.encode(data.toJson());

class AddFloorResponseModel {
  FloorCreatedViaApi? floorCreatedViaApi;

  AddFloorResponseModel({
    this.floorCreatedViaApi,
  });

  factory AddFloorResponseModel.fromJson(Map<String, dynamic> json) =>
      AddFloorResponseModel(
        floorCreatedViaApi: json["floorCreatedViaApi"] == null
            ? null
            : FloorCreatedViaApi.fromJson(json["floorCreatedViaApi"]),
      );

  Map<String, dynamic> toJson() => {
        "floorCreatedViaApi": floorCreatedViaApi?.toJson(),
      };
}

class FloorCreatedViaApi {
  String? name;
  String? code;
  int? propertyId;
  String? description;
  int? createdBy;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  FloorCreatedViaApi({
    this.name,
    this.code,
    this.propertyId,
    this.description,
    this.createdBy,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory FloorCreatedViaApi.fromJson(Map<String, dynamic> json) =>
      FloorCreatedViaApi(
        name: json["name"],
        code: json["code"],
        propertyId: json["property_id"],
        description: json["description"],
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
        "name": name,
        "code": code,
        "property_id": propertyId,
        "description": description,
        "created_by": createdBy,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
