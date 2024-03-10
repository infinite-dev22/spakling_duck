// To parse this JSON data, do
//
//     final paymentSchedulesModel = paymentSchedulesModelFromJson(jsonString);

import 'dart:convert';

import 'package:SmartCase/data_layer/models/smart_model.dart';

List<List<PaymentSchedulesModel>> paymentSchedulesModelFromJson(String str) => List<List<PaymentSchedulesModel>>.from(json.decode(str).map((x) => List<PaymentSchedulesModel>.from(x.map((x) => PaymentSchedulesModel.fromJson(x)))));

String paymentSchedulesModelToJson(List<List<PaymentSchedulesModel>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));

class PaymentSchedulesModel extends SmartModel {
  String? fromDate;
  String? toDate;
  String? balance;
  int? id;

  PaymentSchedulesModel({
    this.fromDate,
    this.toDate,
    this.balance,
    this.id,
  });

  factory PaymentSchedulesModel.fromJson(Map<String, dynamic> json) => PaymentSchedulesModel(
    fromDate: json["from_date"],
    toDate: json["to_date"],
    balance: json["balance"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "from_date": fromDate,
    "to_date": toDate,
    "balance": balance,
    "id": id,
  };

  @override
  int getId() { return id!;
  }

  @override
  String getName() { return '';
  }
}
