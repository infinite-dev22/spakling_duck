import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_layer/dtos/implementation/payment_dto_impl.dart';
import 'package:smart_rent/data_layer/models/payment/add_payment_response_model.dart';
import 'package:smart_rent/data_layer/models/payment/payments_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/payment_repo_impl.dart';
import 'package:smart_rent/utilities/app_init.dart';

part 'payment_event.dart';part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentState()) {
    on<AddPaymentsEvent>(_mapAddPaymentsEventToState);
    on<RefreshPaymentsEvent>(_mapRefreshPaymentsEventToState);
    on<LoadAllPayments>(_mapFetchPaymentsToState);
  }

  _mapFetchPaymentsToState(
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

  _mapAddPaymentsEventToState(
      AddPaymentsEvent event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(
        status: PaymentStatus.loadingAdd, isPaymentLoading: true));
    await PaymentDtoImpl.addPayment(
            currentUserToken.toString(),
            event.paid,
            event.amountDue,
            event.date,
            event.tenantUnitId,
            event.accountId,
            event.paymentModeId,
            event.propertyId,
            event.paymentScheduleId)
        .then((response) {
      print('success ${response.message}');

      if (response != null) {
        emit(state.copyWith(
            status: PaymentStatus.successAdd,
            isPaymentLoading: false,
            addPaymentResponseModel: response,
            message: response.message));
      } else {
        emit(state.copyWith(
          status: PaymentStatus.accessDeniedAdd,
          isPaymentLoading: false,
        ));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          status: PaymentStatus.errorAdd,
          isPaymentLoading: false,
          message: error.toString()));
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
