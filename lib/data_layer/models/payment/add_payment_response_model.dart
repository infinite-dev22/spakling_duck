// To parse this JSON data, do
//
//     final addPaymentResponseModel = addPaymentResponseModelFromJson(jsonString);

import 'dart:convert';

AddPaymentResponseModel addPaymentResponseModelFromJson(String str) => AddPaymentResponseModel.fromJson(json.decode(str));

String addPaymentResponseModelToJson(AddPaymentResponseModel data) => json.encode(data.toJson());

class AddPaymentResponseModel {
  String? message;

  AddPaymentResponseModel({
    this.message,
  });

  factory AddPaymentResponseModel.fromJson(Map<String, dynamic> json) => AddPaymentResponseModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
