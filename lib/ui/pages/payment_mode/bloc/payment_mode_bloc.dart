import 'dart:async';

import 'package:smart_rent/data_layer/models/payment/payment_mode_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/payment_repo_impl.dart';
import 'package:smart_rent/utilities/app_init.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


part 'payment_mode_event.dart';
part 'payment_mode_state.dart';

class PaymentModeBloc extends Bloc<PaymentModeEvent, PaymentModeState> {
  PaymentModeBloc() : super(PaymentModeState()) {
    on<LoadAllPaymentModesEvent>(_mapFetchPaymentModesToState);
  }

  _mapFetchPaymentModesToState(
      LoadAllPaymentModesEvent event, Emitter<PaymentModeState> emit) async {
    emit(state.copyWith(status: PaymentModeStatus.loading));
    await PaymentRepoImpl()
        .getAllPaymentModes(currentUserToken.toString(), event.propertyId)
        .then((paymentAccounts) {
      if (paymentAccounts.isNotEmpty) {
        emit(state.copyWith(
            status: PaymentModeStatus.success, paymentModes: paymentAccounts));
      } else {
        emit(state.copyWith(status: PaymentModeStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: PaymentModeStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }

}
