import 'dart:convert';
import 'dart:io';

import 'package:SmartCase/configs/app_configs.dart';
import 'package:SmartCase/data_layer/models/property/property_category_model.dart';
import 'package:SmartCase/data_layer/repositories/interfaces/property_category_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';


class PropertyCategoryRepoImpl implements PropertyCategoryRepo {
  @override
  Future<List<PropertyCategoryModel>> getALlPropertyCategories(
      String token) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('$appUrl/api/rent/properties/create/prefill');

      var response = await client.get(url, headers: headers);
      print('Categories =${response}');
      List categoryData = jsonDecode(response.body)['categories'];
      if (kDebugMode) {
        print("property categories RESPONSE: $response");
      }
      return categoryData
          .map((employee) => PropertyCategoryModel.fromJson(employee))
          .toList();
    } finally {
      client.close();
    }
  }
}
