class LoginResponse {
  final bool? success;
  final String? token;
  final String? message;

  LoginResponse({
    this.success,
    this.token,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      token: json['token'],
      message: json['message'],
    );
  }
}
