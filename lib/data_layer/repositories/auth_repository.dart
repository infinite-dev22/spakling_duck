

import 'package:smart_rent/data_layer/models/auth/login_model.dart';
import 'package:smart_rent/data_layer/models/auth/login_response.dart';
import 'package:smart_rent/data_layer/services/auth_service.dart';

class AuthRepository {
  static Future<LoginResponse?> signInUser(LoginModel loginModel) async {
    var response = await AuthService.signInUser(loginModel);
    return LoginResponse.fromJson(response);
  }
}
