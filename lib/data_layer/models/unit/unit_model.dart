// To parse this JSON data, do
//
//     final unitListModel = unitListModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/data_layer/models/currency/currency_model.dart';
import 'package:smart_rent/data_layer/models/floor/floor_model.dart';
import 'package:smart_rent/data_layer/models/period/period_model.dart';
import 'package:smart_rent/data_layer/models/smart_model.dart';
import 'package:smart_rent/data_layer/models/unit/unit_type_model.dart';


UnitListModel unitListModelFromJson(String str) => UnitListModel.fromJson(json.decode(str));

String unitListModelToJson(UnitListModel data) => json.encode(data.toJson());

class UnitListModel {
  List<UnitModel>? units;

  UnitListModel({
    this.units,
  });

  factory UnitListModel.fromJson(Map<String, dynamic> json) => UnitListModel(
    units: json["units"] == null ? [] : List<UnitModel>.from(json["units"]!.map((x) => UnitModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "units": units == null ? [] : List<dynamic>.from(units!.map((x) => x.toJson())),
  };
}

class UnitModel extends SmartUnitModel{
  int? id;
  String? name;
  int? amount;
  int? isAvailable;
  String? squareMeters;
  String? description;
  UnitTypeModel? unitTypeModel;
  int? floorId;
  int? scheduleId;
  int? propertyId;
  int? currencyId;
  int? createdBy;
  int? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  FloorModel? floorModel;
  PeriodModel? periodModel;
  CurrencyModel? currencyModel;


  UnitModel({
    this.id,
    this.name,
    this.amount,
    this.isAvailable,
    this.squareMeters,
    this.description,
    this.unitTypeModel,
    this.floorId,
    this.scheduleId,
    this.propertyId,
    this.currencyId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.floorModel,
    this.periodModel,
    this.currencyModel,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
    id: json["id"],
    name: json["name"],
    amount: json["amount"],
    isAvailable: json["is_available"],
    squareMeters: json["square_meters"],
    description: json["description"],
    unitTypeModel: json["unit_type"] == null ? null : UnitTypeModel.fromJson(json["unit_type"]),
    floorId: json["floor_id"],
    scheduleId: json["schedule_id"],
    propertyId: json["property_id"],
    currencyId: json["currency_id"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    floorModel: json["floor"] == null ? null : FloorModel.fromJson(json["floor"]),
    periodModel: json["period"] == null ? null : PeriodModel.fromJson(json["period"]),
    currencyModel: json["currency"] == null ? null : CurrencyModel.fromJson(json["currency"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "amount": amount,
    "is_available": isAvailable,
    "square_meters": squareMeters,
    "description": description,
    "unit_type": unitTypeModel?.toJson(),
    "floor_id": floorId,
    "schedule_id": scheduleId,
    "property_id": propertyId,
    "currency_id": currencyId,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "floor": floorModel?.toJson(),
    "period": periodModel?.toJson(),
    "currency": currencyModel?.toJson(),
  };

  @override
  int getAmount() { return amount!;
  }

  @override
  int getAvailability() { return isAvailable!;}

  @override
  String getDescription() { return description!;
  }

  @override
  int getFloorId() { return floorId!;
  }

  @override
  int getId() { return id!;
  }

  @override
  int getPeriodId() { return periodModel!.id!;
  }

  @override
  int getPropertyId() { return propertyId!;
  }

  @override
  String getUnitName() { return name!;
  }

  @override
  String getUnitNumber() { return '';
  }

  @override
  int getUnitType() { return unitTypeModel!.id!;
  }
}





// // To parse this JSON data, do
// //
// //     final unitModel = unitModelFromJson(jsonString);
//
// import 'dart:convert';
//
// List<UnitModel> unitModelFromJson(String str) =>
//     List<UnitModel>.from(json.decode(str).map((x) => UnitModel.fromJson(x)));
//
// String unitModelToJson(List<UnitModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class UnitModel {
//   int? id;
//   String? name;
//   String? number;
//   int? amount;
//   int? isAvailable;
//   String? squareMeters;
//   String? description;
//   int? unitType;
//   int? floorId;
//   int? scheduleId;
//   int? propertyId;
//   int? currencyId;
//   int? createdBy;
//   dynamic updatedBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   UnitModel({
//     this.id,
//     this.name,
//     this.number,
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
//   factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
//         id: json["id"],
//         name: json["name"],
//         number: json["number"],
//         amount: json["amount"],
//         isAvailable: json["is_available"],
//         squareMeters: json["square_meters"],
//         description: json["description"],
//         unitType: json["unit_type"],
//         floorId: json["floor_id"],
//         scheduleId: json["schedule_id"],
//         propertyId: json["property_id"],
//         currencyId: json["currency_id"],
//         createdBy: json["created_by"],
//         updatedBy: json["updated_by"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "number": number,
//         "amount": amount,
//         "is_available": isAvailable,
//         "square_meters": squareMeters,
//         "description": description,
//         "unit_type": unitType,
//         "floor_id": floorId,
//         "schedule_id": scheduleId,
//         "property_id": propertyId,
//         "currency_id": currencyId,
//         "created_by": createdBy,
//         "updated_by": updatedBy,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
