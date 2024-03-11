// To parse this JSON data, do
//
//     final tenantTypeModel = tenantTypeModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/data_layer/models/smart_model.dart';

List<TenantTypeModel> tenantTypeModelFromJson(String str) =>
    List<TenantTypeModel>.from(
        json.decode(str).map((x) => TenantTypeModel.fromJson(x)));

String tenantTypeModelToJson(List<TenantTypeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TenantTypeModel extends SmartModel {
  int? id;
  String? name;
  String? code;
  String? description;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  TenantTypeModel({
    this.id,
    this.name,
    this.code,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory TenantTypeModel.fromJson(Map<String, dynamic> json) =>
      TenantTypeModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
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
        "name": name,
        "code": code,
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
