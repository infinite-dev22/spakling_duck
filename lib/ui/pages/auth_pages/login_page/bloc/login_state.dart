part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  success,
  loginUser,
  signInUser,
  changeUser,
  forgotPassword,
  focusEmail,
  focusPassword,
  error,
  loading,
  selected,
  noData
}

extension LoginStatusX on LoginStatus {
  bool get isInitial => this == LoginStatus.initial;

  bool get isSuccess => this == LoginStatus.success;

  bool get isError => this == LoginStatus.error;

  bool get isLoading => this == LoginStatus.loading;

  bool get isLoginUser => this == LoginStatus.loginUser;

  bool get isForgotPassword => this == LoginStatus.forgotPassword;

  bool get isSignInUser => this == LoginStatus.signInUser;

  bool get isChangeUser => this == LoginStatus.changeUser;
}

@immutable
class LoginState extends Equatable {
  final bool loginSuccess;
  final String? token;
  final String? message;
  final String? email;
  final String? name;
  final String? image;
  final bool isEmailFocused;
  final bool isPasswordFocus;
  final LoginStatus status;

  const LoginState({
    this.loginSuccess = false,
    this.token,
    this.message,
    this.email,
    this.name,
    this.image,
    this.isEmailFocused = false,
    this.isPasswordFocus = false,
    this.status = LoginStatus.initial,
  });

  @override
  List<Object?> get props => [
        loginSuccess,
        token,
        message,
        email,
        name,
        image,
        isEmailFocused,
        isPasswordFocus,
        status,
      ];

  LoginState copyWith({
    bool? loginSuccess,
    String? token,
    String? message,
    String? email,
    String? name,
    String? image,
    bool? isEmailFocused,
    bool? isPasswordFocus,
    LoginStatus? status,
  }) {
    return LoginState(
      loginSuccess: loginSuccess ?? this.loginSuccess,
      token: token ?? this.token,
      message: message ?? this.message,
      email: email ?? this.email,
      name: name ?? this.name,
      image: image ?? this.image,
      isEmailFocused: isEmailFocused ?? this.isEmailFocused,
      isPasswordFocus: isPasswordFocus ?? this.isPasswordFocus,
      status: status ?? this.status,
    );
  }
}
