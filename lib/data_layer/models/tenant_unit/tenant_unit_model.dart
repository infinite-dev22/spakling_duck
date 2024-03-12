// To parse this JSON data, do
//
//     final tenantUnitListModel = tenantUnitListModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/data_layer/models/currency/currency_model.dart';
import 'package:smart_rent/data_layer/models/payment/payment_schedules_model.dart';
import 'package:smart_rent/data_layer/models/period/period_model.dart';
import 'package:smart_rent/data_layer/models/smart_model.dart';
import 'package:smart_rent/data_layer/models/tenant/tenant_model.dart';


TenantUnitListModel tenantUnitListModelFromJson(String str) => TenantUnitListModel.fromJson(json.decode(str));

String tenantUnitListModelToJson(TenantUnitListModel data) => json.encode(data.toJson());

class TenantUnitListModel {
  List<TenantUnitModel>? tenantunitsonproperty;

  TenantUnitListModel({
    this.tenantunitsonproperty,
  });

  factory TenantUnitListModel.fromJson(Map<String, dynamic> json) => TenantUnitListModel(
    tenantunitsonproperty: json["tenantunitsonproperty"] == null ? [] : List<TenantUnitModel>.from(json["tenantunitsonproperty"]!.map((x) => TenantUnitModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tenantunitsonproperty": tenantunitsonproperty == null ? [] : List<dynamic>.from(tenantunitsonproperty!.map((x) => x.toJson())),
  };
}

class TenantUnitModel extends SmartTenantUnitsModel{
  int? id;
  DateTime? fromDate;
  DateTime? toDate;
  int? amount;
  int? duration;
  int? discountAmount;
  int? currencyId;
  String? description;
  int? unitId;
  int? tenantId;
  int? scheduleId;
  int? propertyId;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  TenantModel? tenant;
  TUnitModel? unit;
  PeriodModel? period;
  CurrencyModel? currencyModel;
  // List<PaymentSchedulesModel>? paymentScheduleModel;

  TenantUnitModel({
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
    this.tenant,
    this.unit,
    this.period,
    this.currencyModel
    // this.paymentScheduleModel,
  });

  factory TenantUnitModel.fromJson(Map<String, dynamic> json) => TenantUnitModel(
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
    tenant: json["tenant"] == null ? null : TenantModel.fromJson(json["tenant"]),
    unit: json["unit"] == null ? null : TUnitModel.fromJson(json["unit"]),
    period: json["period"] == null ? null : PeriodModel.fromJson(json["period"]),
    currencyModel: json["currency"] == null ? null : CurrencyModel.fromJson(json["currency"]),
    // paymentScheduleModel: json["schedules"] == null ? [] : List<PaymentSchedulesModel>.from(json["schedules"]!.map((x) => PaymentSchedulesModel.fromJson(x))),

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
    "tenant": tenant?.toJson(),
    "unit": unit?.toJson(),
    "period": period?.toJson(),
    "currency": currencyModel?.toJson(),
    // "schedules": paymentScheduleModel == null ? [] : List<dynamic>.from(paymentScheduleModel!.map((x) => x.toJson())),

  };

  @override
  int getAmount() { return amount!;
  }

  @override
  int getDiscount() { return discountAmount!;
  }

  @override
  int getId() { return id!;
  }

  @override
  int getTenantId() { return tenant!.id!;
  }

  @override
  int getUnitId() { return unit!.id!;
  }

  @override
  String getTenantName() { return tenant!.clientTypeId == 1
      ? '${tenant!.clientProfiles!.first.firstName} ${tenant!.clientProfiles!.first.lastName}'
      : '${tenant!.clientProfiles!.first.companyName}';
  }

  @override
  String getUnitName() { return unit!.name!;
  }
}

class TUnitModel {
  int? id;
  String? name;
  int? amount;
  int? isAvailable;
  String? squareMeters;
  dynamic description;
  int? unitType;
  int? floorId;
  int? scheduleId;
  int? propertyId;
  int? currencyId;
  int? createdBy;
  int? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  TUnitModel({
    this.id,
    this.name,
    this.amount,
    this.isAvailable,
    this.squareMeters,
    this.description,
    this.unitType,
    this.floorId,
    this.scheduleId,
    this.propertyId,
    this.currencyId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory TUnitModel.fromJson(Map<String, dynamic> json) => TUnitModel(
    id: json["id"],
    name: json["name"],
    amount: json["amount"],
    isAvailable: json["is_available"],
    squareMeters: json["square_meters"],
    description: json["description"],
    unitType: json["unit_type"],
    floorId: json["floor_id"],
    scheduleId: json["schedule_id"],
    propertyId: json["property_id"],
    currencyId: json["currency_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "amount": amount,
    "is_available": isAvailable,
    "square_meters": squareMeters,
    "description": description,
    "unit_type": unitType,
    "floor_id": floorId,
    "schedule_id": scheduleId,
    "property_id": propertyId,
    "currency_id": currencyId,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}