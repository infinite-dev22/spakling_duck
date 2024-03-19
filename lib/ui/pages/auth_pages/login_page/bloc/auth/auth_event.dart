part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticateUser extends AuthEvent {
  final String userName;
  final String password;

  const AuthenticateUser(this.userName, this.password);

  @override
  List<Object?> get props => [userName, password];
}

class AuthInitial extends AuthEvent {}
