import 'dart:convert';

import 'package:smart_rent/configs/app_configs.dart';
import 'package:smart_rent/data_layer/models/auth/login_model.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';


class AuthService {
  static Future<Map<String, dynamic>> signInUser(LoginModel loginModel) async {
    Dio dio = Dio()..interceptors.add(DioCacheInterceptor(options: options));
    dio.options.headers['content-Type'] = "application/json";
    dio.options.headers['Accept'] = "application/json";
    dio.options.followRedirects = false;

    try {
      var response = await dio.post(
          Uri.https(appUrl.replaceRange(0, 8, ''), 'api/login').toString(),
          data: jsonEncode(loginModel.toJson()));

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Error();
      }
    } finally {
      dio.close();
    }
  }
}
