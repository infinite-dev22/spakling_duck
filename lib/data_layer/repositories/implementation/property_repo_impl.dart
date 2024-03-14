import 'dart:convert';
import 'dart:io';

import 'package:smart_rent/configs/app_configs.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/data_layer/repositories/interfaces/property_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';


class PropertyRepoImpl implements PropertyRepo {
  @override
  @override
  Future<List<Property>> getALlProperties(String token) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('$appUrl/api/rent/properties');

      var response = await client.get(url, headers: headers);
      List propertyData = jsonDecode(response.body)['properties'] ?? [];
      if (kDebugMode) {
        print("property RESPONSE: $response");
        print("property Data: $propertyData");
      }
      return propertyData
          .map((property) => Property.fromJson(property))
          .toList();
    } finally {
      client.close();
    }
  }

  @override
  Future<Property> getSingleProperty(int id, String token) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('$appUrl/api/rent/properties/$id');

      var response = await client.get(url, headers: headers);

      if (kDebugMode) {
        print("Property DETAILS RESPONSE: $response");
      }

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Property.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load property details');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load property details');
    } finally {
      client.close();
    }
  }

  @override
  Future<dynamic> addProperty(
      String token,
      String name,
      String location,
      String sqm,
      String description,
      int propertyTypeId,
      int propertyCategoryId) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('$appUrl/api/rent/properties');

      var response = await client.post(
        url,
        headers: headers,
        body: jsonEncode({
          'name': name,
          'location': location,
          'square_meters': sqm,
          'description': description,
          'property_type_id': propertyTypeId,
          'property_category_id': propertyCategoryId,
        }),
      );

      if (kDebugMode) {
        print("Add Property RESPONSE: $response");
      }
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print('add property response body $responseBody');
      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }
}
