// To parse this JSON data, do
//
//     final tenanListModel = tenanListModelFromJson(jsonString);

import 'dart:convert';

import 'package:smart_rent/data_layer/models/smart_model.dart';
import 'package:smart_rent/data_layer/models/tenant/tenant_details_model.dart';
import 'package:smart_rent/data_layer/models/tenant/tenant_type_model.dart';


TenanListModel tenanListModelFromJson(String str) =>
    TenanListModel.fromJson(json.decode(str));

String tenanListModelToJson(TenanListModel data) => json.encode(data.toJson());

class TenanListModel {
  List<TenantModel>? clients;

  TenanListModel({
    this.clients,
  });

  factory TenanListModel.fromJson(Map<String, dynamic> json) => TenanListModel(
        clients: json["clients"] == null
            ? []
            : List<TenantModel>.from(
                json["clients"]!.map((x) => TenantModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "clients": clients == null
            ? []
            : List<dynamic>.from(clients!.map((x) => x.toJson())),
      };
}

class TenantModel extends SmartTenantModel{
  int? id;
  String? number;
  int? clientTypeId;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  TenantTypeModel? clientType;
  List<TenantProfile>? clientProfiles;

  TenantModel({
    this.id,
    this.number,
    this.clientTypeId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.clientType,
    this.clientProfiles,
  });

  factory TenantModel.fromJson(Map<String, dynamic> json) => TenantModel(
        id: json["id"],
        number: json["number"],
        clientTypeId: json["client_type_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        clientType: json["client_type"] == null
            ? null
            : TenantTypeModel.fromJson(json["client_type"]),
        clientProfiles: json["client_profiles"] == null
            ? []
            : List<TenantProfile>.from(
                json["client_profiles"]!.map((x) => TenantProfile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "client_type_id": clientTypeId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "client_type": clientType?.toJson(),
        "client_profiles": clientProfiles == null
            ? []
            : List<dynamic>.from(clientProfiles!.map((x) => x.toJson())),
      };

  @override
  String getBusinessType() { return clientType!.name!;
  }

  @override
  int getBusinessTypeId() { return clientType!.id!;
  }

  @override
  String getDescription() { return clientType!.description!;
  }

  @override
  int getId() { return id!;
  }

  @override
  String getImageDocUrl() { return '';
  }

  @override
  String getName() { return clientTypeId == 1
      ? '${clientProfiles!.first.firstName} ${clientProfiles!.first.lastName}'
      : '${clientProfiles!.first.companyName}';
  }

  @override
  int getNationId() { return clientProfiles![0].nationId!;
  }

  @override
  String getTenantNo() { return number!;
  }

  @override
  String getTenantType() { return clientType!.name!;
  }

  @override
  int getTenantTypeId() { return clientType!.id!;
  }
}

// class TenantType extends {
//   int? id;
//   String? name;
//   String? code;
//   String? description;
//   int? createdBy;
//   dynamic updatedBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   TenantType({
//     this.id,
//     this.name,
//     this.code,
//     this.description,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory TenantType.fromJson(Map<String, dynamic> json) => TenantType(
//     id: json["id"],
//     name: json["name"],
//     code: json["code"],
//     description: json["description"],
//     createdBy: json["created_by"],
//     updatedBy: json["updated_by"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "code": code,
//     "description": description,
//     "created_by": createdBy,
//     "updated_by": updatedBy,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//   };
// }
