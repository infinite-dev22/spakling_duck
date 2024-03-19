part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  success,
  loginUser,
  signInUser,
  changeUser,
  forgotPassword,
  error,
  loading,
  selected,
  noData
}

extension AuthStatusX on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;

  bool get isSuccess => this == AuthStatus.success;

  bool get isError => this == AuthStatus.error;

  bool get isLoading => this == AuthStatus.loading;

  bool get isAuthUser => this == AuthStatus.loginUser;

  bool get isForgotPassword => this == AuthStatus.forgotPassword;

  bool get isSignInUser => this == AuthStatus.signInUser;

  bool get isChangeUser => this == AuthStatus.changeUser;
}

@immutable
class AuthState extends Equatable {
  final bool loginSuccess;
  final String? token;
  final String? message;
  final String? email;
  final String? name;
  final String? image;
  final AuthStatus status;

  const AuthState({
    this.loginSuccess = false,
    this.token,
    this.message,
    this.email,
    this.name,
    this.image,
    this.status = AuthStatus.initial,
  });

  @override
  List<Object?> get props => [
        loginSuccess,
        token,
        message,
        email,
        name,
        image,
        status,
      ];

  AuthState copyWith({
    bool? loginSuccess,
    String? token,
    String? message,
    String? email,
    String? name,
    String? image,
    AuthStatus? status,
  }) {
    return AuthState(
      loginSuccess: loginSuccess ?? this.loginSuccess,
      token: token ?? this.token,
      message: message,
      email: email ?? this.email,
      name: name ?? this.name,
      image: image ?? this.image,
      status: status ?? this.status,
    );
  }
}
