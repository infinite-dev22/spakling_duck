import 'dart:async';

import 'package:smart_rent/data_layer/models/payment/payment_account_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/payment_repo_impl.dart';
import 'package:smart_rent/utilities/app_init.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


part 'payment_account_event.dart';
part 'payment_account_state.dart';

class PaymentAccountBloc extends Bloc<PaymentAccountEvent, PaymentAccountState> {
  PaymentAccountBloc() : super(PaymentAccountState()) {
    on<LoadAllPaymentAccountsEvent>(_mapFetchPaymentAccountsToState);
  }

  _mapFetchPaymentAccountsToState(
      LoadAllPaymentAccountsEvent event, Emitter<PaymentAccountState> emit) async {
    emit(state.copyWith(status: PaymentAccountStatus.loading));
    await PaymentRepoImpl()
        .getAllPaymentAccounts(currentUserToken.toString(), event.propertyId)
        .then((paymentAccounts) {
      if (paymentAccounts.isNotEmpty) {
        emit(state.copyWith(
            status: PaymentAccountStatus.success, paymentAccounts: paymentAccounts));
      } else {
        emit(state.copyWith(status: PaymentAccountStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: PaymentAccountStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }

}
