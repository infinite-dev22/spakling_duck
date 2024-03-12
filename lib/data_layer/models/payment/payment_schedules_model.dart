// To parse this JSON data, do
//
//     final paymentSchedulesModel = paymentSchedulesModelFromJson(jsonString);




// To parse this JSON data, do
//
//     final paymentSchedulesModel = paymentSchedulesModelFromJson(jsonString);

// import 'dart:convert';
//
// import 'package:smart_rent/data_layer/models/smart_model.dart';
//
// List<PaymentSchedulesModel> paymentSchedulesModelFromJson(String str) => List<PaymentSchedulesModel>.from(json.decode(str).map((x) => PaymentSchedulesModel.fromJson(x)));
//
// String paymentSchedulesModelToJson(List<PaymentSchedulesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class PaymentSchedulesModel extends SmartModel{
//   int? id;
//   DateTime? fromDate;
//   DateTime? toDate;
//   int? discountAmount;
//   int? paid;
//   int? balance;
//   int? balanceCForward;
//   String? description;
//   int? unitId;
//   int? tenantId;
//   int? tenantUnitId;
//   int? scheduleId;
//   int? createdBy;
//   int? updatedBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   PaymentSchedulesModel({
//     this.id,
//     this.fromDate,
//     this.toDate,
//     this.discountAmount,
//     this.paid,
//     this.balance,
//     this.balanceCForward,
//     this.description,
//     this.unitId,
//     this.tenantId,
//     this.tenantUnitId,
//     this.scheduleId,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory PaymentSchedulesModel.fromJson(Map<String, dynamic> json) => PaymentSchedulesModel(
//     id: json["id"],
//     fromDate: json["from_date"] == null ? null : DateTime.parse(json["from_date"]),
//     toDate: json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
//     discountAmount: json["discount_amount"],
//     paid: json["paid"],
//     balance: json["balance"],
//     balanceCForward: json["balance_c_forward"],
//     description: json["description"],
//     unitId: json["unit_id"],
//     tenantId: json["tenant_id"],
//     tenantUnitId: json["tenant_unit_id"],
//     scheduleId: json["schedule_id"],
//     createdBy: json["created_by"],
//     updatedBy: json["updated_by"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "from_date": "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
//     "to_date": "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
//     "discount_amount": discountAmount,
//     "paid": paid,
//     "balance": balance,
//     "balance_c_forward": balanceCForward,
//     "description": description,
//     "unit_id": unitId,
//     "tenant_id": tenantId,
//     "tenant_unit_id": tenantUnitId,
//     "schedule_id": scheduleId,
//     "created_by": createdBy,
//     "updated_by": updatedBy,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//   };
//
//
//   @override
//   int getId() { return id!;
//   }
//
//   @override
//   String getName() { return balance.toString();
//   }
// }















import 'dart:convert';

import 'package:smart_rent/data_layer/models/smart_model.dart';

// To parse this JSON data, do
//
//     final paymentSchedulesModel = paymentSchedulesModelFromJson(jsonString);

import 'dart:convert';

List<PaymentSchedulesModel> paymentSchedulesModelFromJson(String str) => List<PaymentSchedulesModel>.from(json.decode(str).map((x) => PaymentSchedulesModel.fromJson(x)));

String paymentSchedulesModelToJson(List<PaymentSchedulesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentSchedulesModel {
  int? id;
  DateTime? fromDate;
  DateTime? toDate;
  int? discountAmount;
  int? paid;
  int? balance;
  int? balanceCForward;
  dynamic description;
  int? unitId;
  int? tenantId;
  int? tenantUnitId;
  int? scheduleId;
  int? createdBy;
  int? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaymentSchedulesModel({
    this.id,
    this.fromDate,
    this.toDate,
    this.discountAmount,
    this.paid,
    this.balance,
    this.balanceCForward,
    this.description,
    this.unitId,
    this.tenantId,
    this.tenantUnitId,
    this.scheduleId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentSchedulesModel.fromJson(Map<String, dynamic> json) => PaymentSchedulesModel(
    id: json["id"],
    fromDate: json["from_date"] == null ? null : DateTime.parse(json["from_date"]),
    toDate: json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
    discountAmount: json["discount_amount"],
    paid: json["paid"],
    balance: json["balance"],
    balanceCForward: json["balance_c_forward"],
    description: json["description"],
    unitId: json["unit_id"],
    tenantId: json["tenant_id"],
    tenantUnitId: json["tenant_unit_id"],
    scheduleId: json["schedule_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "from_date": "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
    "to_date": "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
    "discount_amount": discountAmount,
    "paid": paid,
    "balance": balance,
    "balance_c_forward": balanceCForward,
    "description": description,
    "unit_id": unitId,
    "tenant_id": tenantId,
    "tenant_unit_id": tenantUnitId,
    "schedule_id": scheduleId,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}



//
// List<List<PaymentSchedulesModel>> paymentSchedulesModelFromJson(String str) => List<List<PaymentSchedulesModel>>.from(json.decode(str).map((x) => List<PaymentSchedulesModel>.from(x.map((x) => PaymentSchedulesModel.fromJson(x)))));
//
// String paymentSchedulesModelToJson(List<List<PaymentSchedulesModel>> data) => json.encode(List<dynamic>.from(data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))));
//
// class PaymentSchedulesModel extends SmartModel {
//   String? fromDate;
//   String? toDate;
//   String? balance;
//   int? id;
//
//   PaymentSchedulesModel({
//     this.fromDate,
//     this.toDate,
//     this.balance,
//     this.id,
//   });
//
//   factory PaymentSchedulesModel.fromJson(Map<String, dynamic> json) => PaymentSchedulesModel(
//     fromDate: json["from_date"],
//     toDate: json["to_date"],
//     balance: json["balance"],
//     id: json["id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "from_date": fromDate,
//     "to_date": toDate,
//     "balance": balance,
//     "id": id,
//   };
//
//   @override
//   int getId() { return id!;
//   }
//
//   @override
//   String getName() { return balance.toString();
//   }
// }
