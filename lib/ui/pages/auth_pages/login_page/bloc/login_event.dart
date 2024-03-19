part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class ResetPassword extends LoginEvent {
  final String userName;

  const ResetPassword(this.userName);

  @override
  List<Object?> get props => [userName];
}

class LoginInitial extends LoginEvent {}

class FocusEmail extends LoginEvent {}

class FocusPassword extends LoginEvent {}

class LoginUser extends LoginEvent {}

class SignInUser extends LoginEvent {}

class ChangeUser extends LoginEvent {}

class ForgotPassword extends LoginEvent {}

class RefreshScreen extends LoginEvent {}
