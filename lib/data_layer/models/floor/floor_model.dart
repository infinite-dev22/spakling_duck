// To parse this JSON data, do
//
//     final floorListModel = floorListModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/data_layer/models/smart_model.dart';


FloorListModel floorListModelFromJson(String str) =>
    FloorListModel.fromJson(json.decode(str));

String floorListModelToJson(FloorListModel data) => json.encode(data.toJson());

class FloorListModel {
  List<FloorModel>? floorsonproperty;

  FloorListModel({
    this.floorsonproperty,
  });

  factory FloorListModel.fromJson(Map<String, dynamic> json) => FloorListModel(
        floorsonproperty: json["floorsonproperty"] == null
            ? []
            : List<FloorModel>.from(
                json["floorsonproperty"]!.map((x) => FloorModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "floorsonproperty": floorsonproperty == null
            ? []
            : List<dynamic>.from(floorsonproperty!.map((x) => x.toJson())),
      };
}

class FloorModel extends SmartModel {
  int? id;
  String? code;
  String? name;
  String? description;
  int? propertyId;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  FloorModel({
    this.id,
    this.code,
    this.name,
    this.description,
    this.propertyId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) => FloorModel(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        description: json["description"],
        propertyId: json["property_id"],
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
        "property_id": propertyId,
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
