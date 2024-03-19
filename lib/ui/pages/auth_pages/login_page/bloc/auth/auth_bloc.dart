import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_secure_storage/get_secure_storage.dart';
import 'package:smart_rent/data_layer/models/auth/login_model.dart';
import 'package:smart_rent/data_layer/repositories/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthInitial>(_mapInitialEventToState);
    on<AuthenticateUser>(_mapAuthenticateUserEventToState);
  }

  _mapInitialEventToState(AuthInitial event, Emitter<AuthState> emit) {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      // final box = GetSecureStorage(
      //     password: 'infosec_technologies_ug_smart_case_law_manager');

      // String? email = box.read('email');
      // String? name = box.read('name');
      // String? image = box.read('image');

      // if (email != null && email.isNotEmpty) {
      emit(state.copyWith(
        status: AuthStatus.signInUser,
        // email: email,
        // name: name,
        // image: image,
      ));
      // } else if (email == null && email!.isEmpty) {
      //   emit(state.copyWith(
      //     status: AuthStatus.loginUser,
      //     email: email,
      //     name: name,
      //     image: image,
      //   ));
      // }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: AuthStatus.error));
    }
  }

  _mapAuthenticateUserEventToState(
      AuthenticateUser event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      status: AuthStatus.loading,
      loginSuccess: null,
      message: null,
      token: null,
    ));
    await AuthRepository.signInUser(
      LoginModel(
        userName: event.userName,
        password: event.password,
      ),
    )
        .then((loginResponse) => emit(state.copyWith(
              status: AuthStatus.success,
              loginSuccess: loginResponse?.success,
              message: loginResponse?.message,
              token: loginResponse?.token,
            )))
        .onError((error, stackTrace) =>
            emit(state.copyWith(status: AuthStatus.error)));
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    if (kDebugMode) {
      print("Change: $change");
    }
  }

  @override
  void onEvent(AuthEvent event) {
    super.onEvent(event);
    if (kDebugMode) {
      print("Event: $event");
    }
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    if (kDebugMode) {
      print("Transition: $transition");
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    if (kDebugMode) {
      print("Error: $error");
      print("StackTrace: $stackTrace");
    }
  }
}
