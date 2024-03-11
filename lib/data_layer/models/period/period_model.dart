// To parse this JSON data, do
//
//     final periodModel = periodModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/data_layer/models/smart_model.dart';



List<PeriodModel> periodModelFromJson(String str) => List<PeriodModel>.from(
    json.decode(str).map((x) => PeriodModel.fromJson(x)));

String periodModelToJson(List<PeriodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PeriodModel extends SmartModel {
  int? id;
  String? code;
  String? name;
  String? description;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  PeriodModel({
    this.id,
    this.code,
    this.name,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory PeriodModel.fromJson(Map<String, dynamic> json) => PeriodModel(
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
