import 'dart:convert';
import 'dart:io';

import 'package:smart_rent/configs/app_configs.dart';
import 'package:smart_rent/data_layer/models/period/period_model.dart';
import 'package:smart_rent/data_layer/repositories/interfaces/period_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

class PeriodRepoImpl implements PeriodRepo {
  @override
  Future<List<PeriodModel>> getAllPeriods(
    String token, int id
  ) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('$appUrl/api/rent/units/create/prefill/$id');

      var response = await client.get(url, headers: headers);
      List periodData = jsonDecode(response.body)['periods'];
      if (kDebugMode) {
        print("periods RESPONSE: $response");
      }
      return periodData.map((period) => PeriodModel.fromJson(period)).toList();
    } finally {
      client.close();
    }
  }
}
