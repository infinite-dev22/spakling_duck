part of 'login_bloc.dart';

enum LoginStatus { initial, success, error, loading, selected, noData }

extension LoginStatusX on LoginStatus {
  bool get isInitial => this == LoginStatus.initial;

  bool get isSuccess => this == LoginStatus.success;

  bool get isError => this == LoginStatus.error;

  bool get isLoading => this == LoginStatus.loading;
}

@immutable
class LoginState extends Equatable {
  final String? token;
  final LoginStatus status;

  const LoginState({
    this.token,
    this.status = LoginStatus.initial,
  });

  @override
  List<Object?> get props => [
    status,
  ];

  LoginState copyWith({
    LoginStatus? status,
  }) {
    return LoginState(
      status: status ?? this.status,
    );
  }
}
