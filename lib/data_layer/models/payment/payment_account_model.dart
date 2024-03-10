// To parse this JSON data, do
//
//     final paymentAccountsModel = paymentAccountsModelFromJson(jsonString);

import 'dart:convert';

import 'package:SmartCase/data_layer/models/smart_model.dart';


List<List<PaymentAccountsModel>> paymentAccountsModelFromJson(String str) => List<List<PaymentAccountsModel>>.from(json.decode(str).map((x) => List<PaymentAccountsModel>.from(x.map((x) => PaymentAccountsModel.fromJson(x)))));

String paymentAccountsModelToJson(List<List<PaymentAccountsModel>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class PaymentAccountsModel extends SmartModel {
  int? id;
  String? name;
  String? number;
  int? currencyId;
  int? balance;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaymentAccountsModel({
    this.id,
    this.name,
    this.number,
    this.currencyId,
    this.balance,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentAccountsModel.fromJson(Map<String, dynamic> json) => PaymentAccountsModel(
    id: json["id"],
    name: json["name"],
    number: json["number"],
    currencyId: json["currency_id"],
    balance: json["balance"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "number": number,
    "currency_id": currencyId,
    "balance": balance,
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
