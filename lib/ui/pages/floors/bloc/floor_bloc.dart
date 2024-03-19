import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_layer/models/floor/add_floor_response_model.dart';
import 'package:smart_rent/data_layer/models/floor/floor_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/floor_repo_impl.dart';
import 'package:smart_rent/utilities/app_init.dart';

part 'floor_event.dart';
part 'floor_state.dart';

class FloorBloc extends Bloc<FloorEvent, FloorState> {
  FloorBloc() : super(const FloorState()) {
    on<LoadAllFloorsEvent>(_mapFetchFloorsToState);
  }

  _mapFetchFloorsToState(
      LoadAllFloorsEvent event, Emitter<FloorState> emit) async {
    emit(state.copyWith(status: FloorStatus.loading));
    await FloorRepoImpl()
        .getALlFloors(currentUserToken.toString(), event.id)
        .then((floors) {
      if (floors.isNotEmpty) {
        emit(state.copyWith(status: FloorStatus.success, floors: floors));
      } else {
        emit(state.copyWith(status: FloorStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: FloorStatus.error));
      if (kDebugMode) {
        log("Error: $error");
        log("Stacktrace: $stackTrace");
      }
    });
  }

  @override
  void onChange(Change<FloorState> change) {
    super.onChange(change);
    if (kDebugMode) {
      log("Change: $change");
    }
  }

  @override
  void onEvent(FloorEvent event) {
    super.onEvent(event);
    if (kDebugMode) {
      log("Event: $event");
    }
  }

  @override
  void onTransition(Transition<FloorEvent, FloorState> transition) {
    super.onTransition(transition);
    if (kDebugMode) {
      log("Transition: $transition");
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    if (kDebugMode) {
      log("Error: $error");
      log("StackTrace: $stackTrace");
    }
  }
}
