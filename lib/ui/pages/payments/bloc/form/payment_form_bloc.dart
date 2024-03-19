import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_layer/dtos/implementation/payment_dto_impl.dart';
import 'package:smart_rent/data_layer/models/payment/add_payment_response_model.dart';
import 'package:smart_rent/data_layer/models/payment/payments_model.dart';
import 'package:smart_rent/utilities/app_init.dart';

part 'payment_form_event.dart';
part 'payment_form_state.dart';

class PaymentFormBloc extends Bloc<PaymentFormEvent, PaymentFormState> {
  PaymentFormBloc() : super(PaymentFormState()) {
    on<AddPaymentsEvent>(_mapAddPaymentsEventToState);
  }

  _mapAddPaymentsEventToState(
      AddPaymentsEvent event, Emitter<PaymentFormState> emit) async {
    emit(state.copyWith(
        status: PaymentFormStatus.loading, isPaymentLoading: true));
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
      log('success ${response.message}');

      if (response != null) {
        emit(state.copyWith(
            status: PaymentFormStatus.success,
            isPaymentLoading: false,
            addPaymentResponseModel: response,
            message: response.message));
      } else {
        emit(state.copyWith(
          status: PaymentFormStatus.accessDenied,
          isPaymentLoading: false,
        ));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          status: PaymentFormStatus.error,
          isPaymentLoading: false,
          message: error.toString()));
    });
  }

  @override
  void onEvent(PaymentFormEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<PaymentFormEvent, PaymentFormState> transition) {
    log(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onChange(Change<PaymentFormState> change) {
    log(change.toString());
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    log(error.toString());
    log(stackTrace.toString());
    super.onError(error, stackTrace);
  }
}
