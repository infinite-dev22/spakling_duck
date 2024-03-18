// To parse this JSON data, do
//
//     final tenantUnitDetailsModel = tenantUnitDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/data_layer/models/payment/payment_schedules_model.dart';
import 'package:smart_rent/data_layer/models/period/period_model.dart';
import 'package:smart_rent/data_layer/models/tenant/tenant_model.dart';
import 'package:smart_rent/data_layer/models/tenant_unit/tenant_unit_model.dart';
import 'package:smart_rent/data_layer/models/unit/unit_model.dart';

List<TenantUnitDetailsModel> tenantUnitDetailsModelFromJson(String str) => List<TenantUnitDetailsModel>.from(json.decode(str).map((x) => TenantUnitDetailsModel.fromJson(x)));

String tenantUnitDetailsModelToJson(List<TenantUnitDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TenantUnitDetailsModel {
  int? id;
  DateTime? fromDate;
  DateTime? toDate;
  int? amount;
  int? duration;
  int? discountAmount;
  int? currencyId;
  dynamic description;
  int? unitId;
  int? tenantId;
  int? scheduleId;
  int? propertyId;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  TenantModel? tenantModel;
  TUnitModel? tUnitModel;
  PeriodModel? periodModel;
  List<PaymentSchedulesModel>? paymentScheduleModel;

  TenantUnitDetailsModel({
    this.id,
    this.fromDate,
    this.toDate,
    this.amount,
    this.duration,
    this.discountAmount,
    this.currencyId,
    this.description,
    this.unitId,
    this.tenantId,
    this.scheduleId,
    this.propertyId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.tenantModel,
    this.tUnitModel,
    this.periodModel,
    this.paymentScheduleModel,
  });

  factory TenantUnitDetailsModel.fromJson(Map<String, dynamic> json) => TenantUnitDetailsModel(
    id: json["id"],
    fromDate: json["from_date"] == null ? null : DateTime.parse(json["from_date"]),
    toDate: json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
    amount: json["amount"],
    duration: json["duration"],
    discountAmount: json["discount_amount"],
    currencyId: json["currency_id"],
    description: json["description"],
    unitId: json["unit_id"],
    tenantId: json["tenant_id"],
    scheduleId: json["schedule_id"],
    propertyId: json["property_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    tenantModel: json["tenant"] == null ? null : TenantModel.fromJson(json["tenant"]),
    tUnitModel: json["unit"] == null ? null : TUnitModel.fromJson(json["unit"]),
    periodModel: json["period"] == null ? null : PeriodModel.fromJson(json["period"]),
    paymentScheduleModel: json["schedules"] == null ? [] : List<PaymentSchedulesModel>.from(json["schedules"]!.map((x) => PaymentSchedulesModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "from_date": "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
    "to_date": "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
    "amount": amount,
    "duration": duration,
    "discount_amount": discountAmount,
    "currency_id": currencyId,
    "description": description,
    "unit_id": unitId,
    "tenant_id": tenantId,
    "schedule_id": scheduleId,
    "property_id": propertyId,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "tenant": tenantModel?.toJson(),
    "unit": tUnitModel?.toJson(),
    "period": periodModel?.toJson(),
    "schedules": paymentScheduleModel == null ? [] : List<dynamic>.from(paymentScheduleModel!.map((x) => x.toJson())),
  };
}
//
// class Period {
//   int? id;
//   String? code;
//   String? name;
//   String? description;
//   int? createdBy;
//   dynamic updatedBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Period({
//     this.id,
//     this.code,
//     this.name,
//     this.description,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Period.fromJson(Map<String, dynamic> json) => Period(
//     id: json["id"],
//     code: json["code"],
//     name: json["name"],
//     description: json["description"],
//     createdBy: json["created_by"],
//     updatedBy: json["updated_by"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "code": code,
//     "name": name,
//     "description": description,
//     "created_by": createdBy,
//     "updated_by": updatedBy,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//   };
// }
//
// class Schedule {
//   int? id;
//   DateTime? fromDate;
//   DateTime? toDate;
//   int? discountAmount;
//   int? paid;
//   int? balance;
//   int? balanceCForward;
//   dynamic description;
//   int? unitId;
//   int? tenantId;
//   int? tenantUnitId;
//   int? scheduleId;
//   int? createdBy;
//   int? updatedBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Schedule({
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
//   factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
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
// }
//
// class Tenant {
//   int? id;
//   String? number;
//   int? clientTypeId;
//   int? createdBy;
//   dynamic updatedBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   List<ClientProfile>? clientProfiles;
//
//   Tenant({
//     this.id,
//     this.number,
//     this.clientTypeId,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//     this.clientProfiles,
//   });
//
//   factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
//     id: json["id"],
//     number: json["number"],
//     clientTypeId: json["client_type_id"],
//     createdBy: json["created_by"],
//     updatedBy: json["updated_by"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     clientProfiles: json["client_profiles"] == null ? [] : List<ClientProfile>.from(json["client_profiles"]!.map((x) => ClientProfile.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "number": number,
//     "client_type_id": clientTypeId,
//     "created_by": createdBy,
//     "updated_by": updatedBy,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "client_profiles": clientProfiles == null ? [] : List<dynamic>.from(clientProfiles!.map((x) => x.toJson())),
//   };
// }
//
// class ClientProfile {
//   int? id;
//   String? firstName;
//   dynamic middleName;
//   dynamic lastName;
//   String? companyName;
//   dynamic dateOfBirth;
//   dynamic gender;
//   String? address;
//   String? tin;
//   String? number;
//   dynamic email;
//   dynamic nin;
//   dynamic designation;
//   dynamic description;
//   int? clientId;
//   int? nationId;
//   int? createdBy;
//   dynamic updatedBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   ClientProfile({
//     this.id,
//     this.firstName,
//     this.middleName,
//     this.lastName,
//     this.companyName,
//     this.dateOfBirth,
//     this.gender,
//     this.address,
//     this.tin,
//     this.number,
//     this.email,
//     this.nin,
//     this.designation,
//     this.description,
//     this.clientId,
//     this.nationId,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory ClientProfile.fromJson(Map<String, dynamic> json) => ClientProfile(
//     id: json["id"],
//     firstName: json["first_name"],
//     middleName: json["middle_name"],
//     lastName: json["last_name"],
//     companyName: json["company_name"],
//     dateOfBirth: json["date_of_birth"],
//     gender: json["gender"],
//     address: json["address"],
//     tin: json["tin"],
//     number: json["number"],
//     email: json["email"],
//     nin: json["nin"],
//     designation: json["designation"],
//     description: json["description"],
//     clientId: json["client_id"],
//     nationId: json["nation_id"],
//     createdBy: json["created_by"],
//     updatedBy: json["updated_by"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "first_name": firstName,
//     "middle_name": middleName,
//     "last_name": lastName,
//     "company_name": companyName,
//     "date_of_birth": dateOfBirth,
//     "gender": gender,
//     "address": address,
//     "tin": tin,
//     "number": number,
//     "email": email,
//     "nin": nin,
//     "designation": designation,
//     "description": description,
//     "client_id": clientId,
//     "nation_id": nationId,
//     "created_by": createdBy,
//     "updated_by": updatedBy,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//   };
// }
//
// class Unit {
//   int? id;
//   String? name;
//   int? amount;
//   int? isAvailable;
//   String? squareMeters;
//   dynamic description;
//   int? unitType;
//   int? floorId;
//   int? scheduleId;
//   int? propertyId;
//   int? currencyId;
//   int? createdBy;
//   int? updatedBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Unit({
//     this.id,
//     this.name,
//     this.amount,
//     this.isAvailable,
//     this.squareMeters,
//     this.description,
//     this.unitType,
//     this.floorId,
//     this.scheduleId,
//     this.propertyId,
//     this.currencyId,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Unit.fromJson(Map<String, dynamic> json) => Unit(
//     id: json["id"],
//     name: json["name"],
//     amount: json["amount"],
//     isAvailable: json["is_available"],
//     squareMeters: json["square_meters"],
//     description: json["description"],
//     unitType: json["unit_type"],
//     floorId: json["floor_id"],
//     scheduleId: json["schedule_id"],
//     propertyId: json["property_id"],
//     currencyId: json["currency_id"],
//     createdBy: json["created_by"],
//     updatedBy: json["updated_by"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "amount": amount,
//     "is_available": isAvailable,
//     "square_meters": squareMeters,
//     "description": description,
//     "unit_type": unitType,
//     "floor_id": floorId,
//     "schedule_id": scheduleId,
//     "property_id": propertyId,
//     "currency_id": currencyId,
//     "created_by": createdBy,
//     "updated_by": updatedBy,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//   };
// }
