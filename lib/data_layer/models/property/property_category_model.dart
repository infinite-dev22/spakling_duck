// To parse this JSON data, do
//
//     final propertyCategoryModel = propertyCategoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:SmartCase/data_layer/models/smart_model.dart';

List<PropertyCategoryModel> propertyCategoryModelFromJson(String str) =>
    List<PropertyCategoryModel>.from(
        json.decode(str).map((x) => PropertyCategoryModel.fromJson(x)));

String propertyCategoryModelToJson(List<PropertyCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PropertyCategoryModel extends SmartModel {
  int? id;
  String? code;
  String? name;
  String? description;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  PropertyCategoryModel({
    this.id,
    this.code,
    this.name,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory PropertyCategoryModel.fromJson(Map<String, dynamic> json) =>
      PropertyCategoryModel(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        description: json["description"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "description": description,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  int getId() {
    return id!;
  }

  @override
  String getName() {
    return name!;
  }
}
