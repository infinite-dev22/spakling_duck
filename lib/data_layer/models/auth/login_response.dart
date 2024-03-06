class LoginResponse {
  final bool? success;
  final String? token;
  final String? message;

  LoginResponse({
    this.success,
    this.token,
    this.message,
  });

  factory LoginResponse.fromJsonToShow(Map<String, dynamic> json) =>
      LoginResponse(
        success: json['success'],
        token: json['token'],
        message: json['message'],
      );
}
