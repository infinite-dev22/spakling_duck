import 'dart:async';

import 'package:smart_rent/data_layer/models/period/period_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/period_model_repo_impl.dart';
import 'package:smart_rent/utilities/app_init.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


part 'period_event.dart';
part 'period_state.dart';

class PeriodBloc extends Bloc<PeriodEvent, PeriodState> {
  PeriodBloc() : super(PeriodState()) {
    on<LoadAllPeriodsEvent>(_mapFetchPeriodsToState);
    on<SelectPeriodEvent>(_mapSelectPeriodToState);
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

  _mapSelectPeriodToState(
      SelectPeriodEvent event, Emitter<PeriodState> emit) async {
    emit(
      state.copyWith(
        status: PeriodStatus.durationSelected,
        durationIdSelected: event.durationIdSelected,
      ),
    );
  }

  @override
  void onChange(Change<PeriodState> change) {
    super.onChange(change);
    if (kDebugMode) {
      print("Change: $change");
    }
  }

  @override
  void onEvent(PeriodEvent event) {
    super.onEvent(event);
    if (kDebugMode) {
      print("Event: $event");
    }
  }

  @override
  void onTransition(Transition<PeriodEvent, PeriodState> transition) {
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
