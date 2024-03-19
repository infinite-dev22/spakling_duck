import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_layer/dtos/implementation/floor_dto_impl.dart';
import 'package:smart_rent/data_layer/models/floor/add_floor_response_model.dart';
import 'package:smart_rent/data_layer/models/floor/floor_model.dart';
import 'package:smart_rent/utilities/app_init.dart';

part 'floor_form_event.dart';
part 'floor_form_state.dart';

class FloorFormBloc extends Bloc<FloorFormEvent, FloorFormState> {
  FloorFormBloc() : super(const FloorFormState()) {
    on<AddFloorEvent>(_mapAddFloorFormEventToState);
  }

  _mapAddFloorFormEventToState(
      AddFloorEvent event, Emitter<FloorFormState> emit) async {
    emit(state.copyWith(status: FloorFormStatus.loading, isFloorLoading: true));
    await FloorDtoImpl.addFloor(currentUserToken.toString(), event.propertyId,
            event.floorName, event.description)
        .then((response) {
      log('success ${response.floorCreatedViaApi}');

      if (response != null) {
        emit(state.copyWith(
            status: FloorFormStatus.success,
            isFloorLoading: false,
            floorResponseModel: response));
      } else {
        emit(state.copyWith(
          status: FloorFormStatus.accessDenied,
          isFloorLoading: false,
        ));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          status: FloorFormStatus.error,
          isFloorLoading: false,
          message: error.toString()));
    });
  }

  // _mapViewSingleFloorDetailsEventToState(LoadSinglePropertyEvent event, Emitter<PropertyState> emit) async {
  //   emit(state.copyWith(status: PropertyStatus.loadingDetails,));
  //   await PropertyRepoImpl().getSingleProperty(event.id, userStorage.read('accessToken').toString()).then((property) {
  //     if(property != null) {
  //       emit(state.copyWith(status: PropertyStatus.successDetails, property: property));
  //     } else {
  //       emit(state.copyWith(status: PropertyStatus.emptyDetails, property: null));
  //     }
  //   }).onError((error, stackTrace) {
  //     emit(state.copyWith(status: PropertyStatus.errorDetails, isPropertyLoading: false));
  //   });
  //
  // }

  @override
  void onChange(Change<FloorFormState> change) {
    super.onChange(change);
    if (kDebugMode) {
      log("Change: $change");
    }
  }

  @override
  void onEvent(FloorFormEvent event) {
    super.onEvent(event);
    if (kDebugMode) {
      log("Event: $event");
    }
  }

  @override
  void onTransition(Transition<FloorFormEvent, FloorFormState> transition) {
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
