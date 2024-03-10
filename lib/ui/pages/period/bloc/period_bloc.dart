import 'dart:async';

import 'package:SmartCase/data_layer/models/period/period_model.dart';
import 'package:SmartCase/data_layer/repositories/implementation/period_model_repo_impl.dart';
import 'package:SmartCase/utilities/app_init.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


part 'period_event.dart';
part 'period_state.dart';

class PeriodBloc extends Bloc<PeriodEvent, PeriodState> {
  PeriodBloc() : super(PeriodState()) {
    on<LoadAllPeriodsEvent>(_mapFetchPeriodsToState);
  }

  _mapFetchPeriodsToState(
      LoadAllPeriodsEvent event, Emitter<PeriodState> emit) async {
    emit(state.copyWith(status: PeriodStatus.loading));
    await PeriodRepoImpl()
        .getAllPeriods(currentUserToken.toString(), event.id)
        .then((periods) {
      if (periods.isNotEmpty) {
        emit(state.copyWith(status: PeriodStatus.success, periods: periods));
      } else {
        emit(state.copyWith(status: PeriodStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: PeriodStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }
}
