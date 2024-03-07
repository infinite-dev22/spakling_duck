import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:smart_rent/configs/app_configs.dart';
import 'package:smart_rent/data_layer/models/floor/floor_model.dart';
import 'package:smart_rent/data_layer/repositories/interfaces/floor_repo.dart';

class FloorRepoImpl implements FloorRepo {
  @override
  Future<List<FloorModel>> getALlFloors(String token, int id) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('$appUrl/api/rent/floorsonproperty/$id');

      var response = await client.get(url, headers: headers);
      List floorData = jsonDecode(response.body)['floorsonproperty'];
      if (kDebugMode) {
        print("floor RESPONSE: $response");
      }
      return floorData.map((floor) => FloorModel.fromJson(floor)).toList();
    } finally {
      client.close();
    }
  }

  @override
  Future<dynamic> addFloor(String token, int propertyId, String floorName,
      String? description) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('$appUrl/api/rent/floors');

      var response = await client.post(
        url,
        headers: headers,
        body: jsonEncode({
          'name': floorName,
          // 'code': code,
          'description': description,
          'property_id': propertyId,
        }),
      );

      if (kDebugMode) {
        print("Add floor RESPONSE: $response");
      }
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print('floor response body $responseBody');
      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }
}
