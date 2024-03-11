import 'dart:async';

import 'package:smart_rent/data_layer/models/payment/payment_schedules_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/payment_repo_impl.dart';
import 'package:smart_rent/utilities/app_init.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


part 'payment_schedules_event.dart';
part 'payment_schedules_state.dart';

class PaymentSchedulesBloc extends Bloc<PaymentSchedulesEvent, PaymentSchedulesState> {
  PaymentSchedulesBloc() : super(PaymentSchedulesState()) {
    on<LoadAllPaymentSchedulesEvent>(_mapFetchPaymentSchedulesToState);
  }

  _mapFetchPaymentSchedulesToState(
      LoadAllPaymentSchedulesEvent event, Emitter<PaymentSchedulesState> emit) async {
    emit(state.copyWith(status: PaymentSchedulesStatus.loading));
    await PaymentRepoImpl()
        .getAllPaymentSchedules(currentUserToken.toString(), event.tenantUnitId,)
        .then((schedules) {
      if (schedules.isNotEmpty) {
        emit(state.copyWith(
            status: PaymentSchedulesStatus.success, paymentSchedules: schedules));
      } else {
        emit(state.copyWith(status: PaymentSchedulesStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: PaymentSchedulesStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }


  @override
  void onEvent(PaymentSchedulesEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<PaymentSchedulesEvent, PaymentSchedulesState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onChange(Change<PaymentSchedulesState> change) {
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
