import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_layer/models/payment/add_payment_response_model.dart';
import 'package:smart_rent/data_layer/models/payment/payments_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/payment_repo_impl.dart';
import 'package:smart_rent/utilities/app_init.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState()) {
    on<RefreshPaymentsEvent>(_mapRefreshPaymentsEventToState);
    on<LoadAllPayments>(_mapFetchAllPaymentsToState);
    on<LoadPayments>(_mapFetchPaymentsToState);
  }

  _mapFetchAllPaymentsToState(
      LoadAllPayments event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(status: PaymentStatus.loading));

    await PaymentRepoImpl()
        .getAllPayments(currentUserToken.toString(), event.propertyId)
        .then((floors) {
      if (floors.isNotEmpty) {
        emit(state.copyWith(status: PaymentStatus.success, payments: floors));
      } else {
        emit(state.copyWith(status: PaymentStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: PaymentStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }

  _mapFetchPaymentsToState(
      LoadPayments event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(status: PaymentStatus.loading));

    await PaymentRepoImpl()
        .getPayments(currentUserToken.toString())
        .then((floors) {
      if (floors.isNotEmpty) {
        emit(state.copyWith(status: PaymentStatus.success, payments: floors));
      } else {
        emit(state.copyWith(status: PaymentStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: PaymentStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }

  _mapRefreshPaymentsEventToState(
      RefreshPaymentsEvent event, Emitter<PaymentState> emit) async {
    await PaymentRepoImpl()
        .getAllPayments(currentUserToken.toString(), event.propertyId)
        .then((floors) {
      if (floors.isNotEmpty) {
        emit(state.copyWith(status: PaymentStatus.success, payments: floors));
      } else {
        emit(state.copyWith(status: PaymentStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: PaymentStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }

  @override
  void onEvent(PaymentEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<PaymentEvent, PaymentState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onChange(Change<PaymentState> change) {
    print(change);
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print(error);
    print(stackTrace);
    super.onError(error, stackTrace);
  }
}
