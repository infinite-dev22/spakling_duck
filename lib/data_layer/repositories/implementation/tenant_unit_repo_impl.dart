import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:SmartCase/configs/app_configs.dart';
import 'package:SmartCase/data_layer/models/tenant_unit/tenant_unit_model.dart';
import 'package:SmartCase/data_layer/repositories/interfaces/tenant_unit_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';


class TenantUnitRepoImpl implements TenantUnitRepo {
  @override
  Future<List<TenantUnitModel>> getALlTenantUnits(String token, int id) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url =
          Uri.parse('$appUrl/api/rent/tenantunitsonproperty/$id');

      var response = await client.get(url, headers: headers);
      print('Tenant Unist ${response.body}');
      List tenantUnitData = jsonDecode(response.body)['tenantunitsonproperty'] ?? [];
      // return [];
      if (kDebugMode) {
        print("tenant unit RESPONSE: $response");
      }
      return tenantUnitData
          .map((tenantUnit) => TenantUnitModel.fromJson(tenantUnit))
          .toList();
    } finally {
      client.close();
    }
  }


  @override
  Future<dynamic> addTenantUnit(String token, int tenantId, int unitId, int periodId, String fromDate,
      String toDate, String unitAmount, int currencyId, String agreedAmount, String description, int propertyId) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      print("Soon Posting");

      var url = Uri.parse('$appUrl/api/rent/tenantunits');

      print("Soon Posting: URL Created");

      log("POST_DATA: {"
        '\"from_date\": \"$fromDate\",'
        '\"to_date\": \"$toDate\",'
        '\"amount\": \"$unitAmount\",'
        '\"discount_amount\": \"$agreedAmount\",'
        '\"description\": \"$description\",'
        '\"unit_id\": \"$unitId\",'
        '\"tenant_id\": \"$tenantId\",'
        '\"schedule_id\": \"$periodId\",'
        '\"property_id\": \"$propertyId\",'
        '\"currency_id\": \"$currencyId\",'
      "}");

      var response = await client.post(
        url,
        headers: headers,
        body: jsonEncode({
          "from_date": fromDate,
          "to_date": toDate,
          "amount": unitAmount,
          "discount_amount": agreedAmount,
          "description": description,
          "unit_id": unitId,
          "tenant_id": tenantId,
          "schedule_id": periodId,
          "property_id": propertyId,
          "currency_id": currencyId
        }),
      );

      if (kDebugMode) {
        print("Add Tenant Unit RESPONSE: $response");
      }
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print('Tenant Unit Addition response body $responseBody');
      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }


}
