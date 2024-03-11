import 'dart:convert';
import 'dart:io';

import 'package:smart_rent/configs/app_configs.dart';
import 'package:smart_rent/data_layer/models/tenant/tenant_details_model.dart';
import 'package:smart_rent/data_layer/models/tenant/tenant_model.dart';
import 'package:smart_rent/data_layer/models/tenant/tenant_type_model.dart';
import 'package:smart_rent/data_layer/repositories/interfaces/tenant_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';


class TenantRepoImpl implements TenantRepo {
  @override
  Future<List<TenantModel>> getALlTenants(String token) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('$appUrl/api/crm/clients');

      var response = await client.get(url, headers: headers);
      print('My clients = ${response.body}');
      List tenantData = jsonDecode(response.body)['clients'];
      if (kDebugMode) {
        print("tenants RESPONSE: $response");
      }
      return tenantData
          .map((employee) => TenantModel.fromJson(employee))
          .toList();


    } finally {
      client.close();
    }
  }

  @override
  Future<TenantDetailsModel> getSingleTenant(
    String token,
    int id,
  ) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('$appUrl/api/crm/clients/$id');

      var response = await client.get(url, headers: headers);

      if (kDebugMode) {
        print("Tenant DETAILS RESPONSE: $response");
      }

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return TenantDetailsModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load tenant details');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load tenant details');
    } finally {
      client.close();
    }
  }

  @override
  Future<List<TenantTypeModel>> getALlTenantTypes(String token) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('$appUrl/api/crm/clienttypes');

      var response = await client.get(url, headers: headers);
      List tenantTypes = jsonDecode(response.body);
      if (kDebugMode) {
        print("tenant types RESPONSE: $response");
      }
      return tenantTypes.map((type) => TenantTypeModel.fromJson(type)).toList();
    } finally {
      client.close();
    }
  }
}
