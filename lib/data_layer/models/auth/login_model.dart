class LoginModel {
  final String userName;
  final String password;

  LoginModel({
    required this.userName,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "email": userName,
        "password": password,
      };
}
