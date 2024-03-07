import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/configs/app_configs.dart';
import 'package:smart_rent/data_layer/models/property/property_types_model.dart';
import 'package:smart_rent/data_layer/repositories/interfaces/property_type_repo.dart';


class PropertyTypeRepoImpl implements PropertyTypeRepo {
  @override
  Future<List<PropertyTypeModel>> getALlPropertyTypes(String token) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('$appUrl/api/rent/properties/create/prefill');

      var response = await client.get(url, headers: headers);
      print('Properties =${response}');
      List typesData = jsonDecode(response.body)['types'];
      if (kDebugMode) {
        print("property types RESPONSE: $response");
      }
      return typesData
          .map((employee) => PropertyTypeModel.fromJson(employee))
          .toList();
    } finally {
      client.close();
    }
  }
}
