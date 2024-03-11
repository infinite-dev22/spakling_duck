// To parse this JSON data, do
//
//     final paymentModeModel = paymentModeModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/data_layer/models/smart_model.dart';


List<List<PaymentModeModel>> paymentModeModelFromJson(String str) => List<List<PaymentModeModel>>.from(json.decode(str).map((x) => List<PaymentModeModel>.from(x.map((x) => PaymentModeModel.fromJson(x)))));

String paymentModeModelToJson(List<List<PaymentModeModel>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class PaymentModeModel extends SmartModel{
  int? id;
  String? name;
  String? code;
  String? description;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaymentModeModel({
    this.id,
    this.name,
    this.code,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentModeModel.fromJson(Map<String, dynamic> json) => PaymentModeModel(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    description: json["description"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
  int getId() { return id!;
  }

  @override
  String getName() { return name!;
  }
}
