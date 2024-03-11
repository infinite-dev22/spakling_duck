import 'dart:convert';
import 'dart:io';

import 'package:smart_rent/configs/app_configs.dart';
import 'package:smart_rent/data_layer/models/payment/payment_account_model.dart';
import 'package:smart_rent/data_layer/models/payment/payment_mode_model.dart';
import 'package:smart_rent/data_layer/models/payment/payment_schedules_model.dart';
import 'package:smart_rent/data_layer/repositories/interfaces/payment_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';


class PaymentRepoImpl implements PaymentRepo {

  @override
  Future<List<PaymentAccountsModel>> getAllPaymentAccounts(
      String token, int propertyId
      ) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('$appUrl/api/rent/payments/create/prefill/$propertyId');

      var response = await client.get(url, headers: headers);
      List accountData = jsonDecode(response.body)['accounts'];
      if (kDebugMode) {
        print("payment accounts RESPONSE: ${response.body}");
        print("payment accounts data: ${accountData}");
      }
      return accountData
          .map((nation) => PaymentAccountsModel.fromJson(nation))
          .toList();
    } finally {
      client.close();
    }
  }


  @override
  Future<List<PaymentModeModel>> getAllPaymentModes(
      String token, int propertyId
      ) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('$appUrl/api/rent/payments/create/prefill/$propertyId');

      var response = await client.get(url, headers: headers);
      List modeData = jsonDecode(response.body)['paymentmodes'];
      if (kDebugMode) {
        print("payment modes RESPONSE: ${response.body}");
        print("payment modes data: ${modeData}");
      }
      return modeData
          .map((payment) => PaymentModeModel.fromJson(payment))
          .toList();
    } finally {
      client.close();
    }
  }


  @override
  Future<List<PaymentSchedulesModel>> getAllPaymentSchedules(
      String token, int tenantUnitId,
      ) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      // var url = Uri.parse('$appUrl/api/rent/payments/create/prefill/$propertyId');
      // var url = Uri.parse('$appUrl/api/rent/gettenantunitschedules/$tenantUnitId');
      var url =  Uri.parse('$appUrl/api/rent/tenantunitsonproperty/$tenantUnitId');


      var response = await client.get(url, headers: headers);
      List schedulesData = jsonDecode(response.body)['tenantunitsonproperty'][0]['schedules'];
      if (kDebugMode) {
        print("payment schedules RESPONSE: $response");
        print("payment schedules Data: ${response.body}");
        print("payment schedules List: $schedulesData");
      }
      return schedulesData
          .map((payment) => PaymentSchedulesModel.fromJson(payment))
          .toList();
    } finally {
      client.close();
    }
  }


  @override
  Future<dynamic> addPayment(String token, String paid, String amountDue,
      String date, int tenantUnitId, int accountId, int paymentModeId,
      int propertyId, List<String> paymentScheduleId) async {
    var client = RetryClient(http.Client());
    try {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token'
      };

      var url = Uri.parse('$appUrl/api/rent/payments');

      var response = await client.post(
        url,
        headers: headers,
        body: jsonEncode({
          "paid": paid,
          "amount_due": amountDue,
          "date": date,
          "tenant_unit_id": tenantUnitId,
          "account_id": accountId,
          "payment_mode_id": paymentModeId,
          "property_id": propertyId,
          "payment_schedule_id": paymentScheduleId
        }),
      );

      if (kDebugMode) {
        print("Add Payments RESPONSE: $response");
      }
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      print('Add Payments response body $responseBody');
      return jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

}
