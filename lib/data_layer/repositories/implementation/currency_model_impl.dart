import 'dart:convert';
import 'dart:io';

import 'package:smart_rent/configs/app_configs.dart';
import 'package:smart_rent/data_layer/models/currency/currency_model.dart';
import 'package:smart_rent/data_layer/repositories/interfaces/currency_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';


class CurrencyRepoImpl implements CurrencyRepo {
  @override
  Future<List<CurrencyModel>> getAllCurrencies(
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
      List currencyData = jsonDecode(response.body)['currencies'];
      if (kDebugMode) {
        print("currencies RESPONSE: $response");
      }
      return currencyData
          .map((nation) => CurrencyModel.fromJson(nation))
          .toList();
    } finally {
      client.close();
    }
  }
}
