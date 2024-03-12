// To parse this JSON data, do
//
//     final paymentTenantUnitScheduleModel = paymentTenantUnitScheduleModelFromJson(jsonString);

import 'dart:convert';

List<PaymentTenantUnitScheduleModel> paymentTenantUnitScheduleModelFromJson(String str) => List<PaymentTenantUnitScheduleModel>.from(json.decode(str).map((x) => PaymentTenantUnitScheduleModel.fromJson(x)));

String paymentTenantUnitScheduleModelToJson(List<PaymentTenantUnitScheduleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentTenantUnitScheduleModel {
  String? fromdate;
  String? todate;
  String? balance;
  int? id;

  PaymentTenantUnitScheduleModel({
    this.fromdate,
    this.todate,
    this.balance,
    this.id,
  });

  factory PaymentTenantUnitScheduleModel.fromJson(Map<String, dynamic> json) => PaymentTenantUnitScheduleModel(
    fromdate: json["fromdate"],
    todate: json["todate"],
    balance: json["balance"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "fromdate": fromdate,
    "todate": todate,
    "balance": balance,
    "id": id,
  };
}
