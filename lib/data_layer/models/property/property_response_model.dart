// To parse this JSON data, do
//
//     final propertyModel = propertyModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final propertyModel = propertyModelFromJson(jsonString);

import 'dart:convert';

import 'package:SmartCase/data_layer/models/property/property_category_model.dart';
import 'package:SmartCase/data_layer/models/property/property_types_model.dart';
import 'package:SmartCase/data_layer/models/smart_model.dart';

PropertyModel propertyModelFromJson(String str) =>
    PropertyModel.fromJson(json.decode(str));

String propertyModelToJson(PropertyModel data) => json.encode(data.toJson());

class PropertyModel {
  List<Property>? properties;

  PropertyModel({
    this.properties,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
        properties: json["properties"] == null
            ? []
            : List<Property>.from(
                json["properties"]!.map((x) => Property.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "properties": properties == null
            ? []
            : List<dynamic>.from(properties!.map((x) => x.toJson())),
      };
}

class Property extends SmartPropertyModel {
  int? id;
  String? name;
  String? number;
  String? location;
  String? squareMeters;
  String? description;
  int? propertyTypeId;
  int? propertyCategoryId;
  int? createdBy;
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  PropertyTypeModel? propertyType;
  PropertyCategoryModel? propertyCategoryModel;

  Property({
    this.id,
    this.name,
    this.number,
    this.location,
    this.squareMeters,
    this.description,
    this.propertyTypeId,
    this.propertyCategoryId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.propertyType,
    this.propertyCategoryModel,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"],
        name: json["name"],
        number: json["number"],
        location: json["location"],
        squareMeters: json["square_meters"],
        description: json["description"],
        propertyTypeId: json["property_type_id"],
        propertyCategoryId: json["property_category_id"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        propertyType: json["property_type"] == null
            ? null
            : PropertyTypeModel.fromJson(json["property_type"]),
        propertyCategoryModel: json["category"] == null
            ? null
            : PropertyCategoryModel.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "number": number,
        "location": location,
        "square_meters": squareMeters,
        "description": description,
        "property_type_id": propertyTypeId,
        "property_category_id": propertyCategoryId,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "property_type": propertyType?.toJson(),
        "category": propertyCategoryModel?.toJson(),
      };

  @override
  int getCategoryTypeId() {
    return propertyCategoryId!;
  }

  @override
  String getDescription() {
    return description!;
  }

  @override
  int getId() {
    return id!;
  }

  @override
  String getImageDocUrl() {
    return '';
  }

  @override
  String getLocation() {
    return location!;
  }

  @override
  int getMainImage() {
    return 0;
  }

  @override
  String getName() {
    return name!;
  }

  @override
  String getNumber() {
    return number!;
  }

  @override
  int getOrganisationId() {
    return 0;
  }

  @override
  int getPropertyTypeId() {
    return propertyTypeId!;
  }

  @override
  String getSquareMeters() {
    return squareMeters!;
  }

  @override
  String getPropertyCategoryName() {
    return propertyCategoryModel!.name!;
  }
}

//
// import 'dart:convert';
//
// import 'package:smart_rent/models/general/smart_model.dart';
//
// PropertyModel propertyModelFromJson(String str) => PropertyModel.fromJson(json.decode(str));
//
// String propertyModelToJson(PropertyModel data) => json.encode(data.toJson());
//
// class PropertyModel {
//   List<Property>? clients;
//
//   PropertyModel({
//     this.clients,
//   });
//
//   factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
//     clients: json["clients"] == null ? [] : List<Property>.from(json["clients"]!.map((x) => Property.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "clients": clients == null ? [] : List<dynamic>.from(clients!.map((x) => x.toJson())),
//   };
// }
//
// class Property extends SmartPropertyModel{
//   int? id;
//   String? name;
//   String? number;
//   String? location;
//   String? squareMeters;
//   String? description;
//   int? propertyTypeId;
//   int? propertyCategoryId;
//   int? createdBy;
//   dynamic updatedBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   PropertyType? propertyType;
//
//   Property({
//     this.id,
//     this.name,
//     this.number,
//     this.location,
//     this.squareMeters,
//     this.description,
//     this.propertyTypeId,
//     this.propertyCategoryId,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//     this.propertyType,
//   });
//
//   factory Property.fromJson(Map<String, dynamic> json) => Property(
//     id: json["id"],
//     name: json["name"],
//     number: json["number"],
//     location: json["location"],
//     squareMeters: json["square_meters"],
//     description: json["description"],
//     propertyTypeId: json["property_type_id"],
//     propertyCategoryId: json["property_category_id"],
//     createdBy: json["created_by"],
//     updatedBy: json["updated_by"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     propertyType: json["property_type"] == null ? null : PropertyType.fromJson(json["property_type"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "number": number,
//     "location": location,
//     "square_meters": squareMeters,
//     "description": description,
//     "property_type_id": propertyTypeId,
//     "property_category_id": propertyCategoryId,
//     "created_by": createdBy,
//     "updated_by": updatedBy,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "property_type": propertyType?.toJson(),
//   };
//
//   @override
//   int getCategoryTypeId() { return propertyCategoryId!;
//   }
//
//   @override
//   String getDescription() { return description!;
//   }
//
//   @override
//   int getId() { return id!;
//   }
//
//   @override
//   String getImageDocUrl() { return '';
//   }
//
//   @override
//   String getLocation() { return location!;
//   }
//
//   @override
//   int getMainImage() { return 0;
//   }
//
//   @override
//   String getName() { return name!;
//   }
//
//   @override
//   int getOrganisationId() { return 0;
//   }
//
//   @override
//   int getPropertyTypeId() { return propertyTypeId!;
//   }
//
//   @override
//   String getSquareMeters() { return squareMeters!;
//   }
// }
//
// class PropertyType {
//   int? id;
//   String? code;
//   String? name;
//   String? description;
//   int? createdBy;
//   dynamic updatedBy;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   PropertyType({
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
//   factory PropertyType.fromJson(Map<String, dynamic> json) => PropertyType(
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
