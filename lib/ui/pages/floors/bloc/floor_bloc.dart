import 'dart:async';

import 'package:smart_rent/data_layer/dtos/implementation/floor_dto_impl.dart';
import 'package:smart_rent/data_layer/models/floor/add_floor_response_model.dart';
import 'package:smart_rent/data_layer/models/floor/floor_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/floor_repo_impl.dart';
import 'package:smart_rent/utilities/app_init.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


part 'floor_event.dart';part 'floor_state.dart';

class FloorBloc extends Bloc<FloorEvent, FloorState> {
  FloorBloc() : super(FloorState()) {
    on<LoadAllFloorsEvent>(_mapFetchFloorsToState);
    on<AddFloorEvent>(_mapAddFloorEventToState);
  }

  _mapFetchFloorsToState(
      LoadAllFloorsEvent event, Emitter<FloorState> emit) async {
    print("JON MARK");
    emit(state.copyWith(status: FloorStatus.loading));
    print("JANET");
    await FloorRepoImpl()
        .getALlFloors(currentUserToken.toString(), event.id)
        .then((floors) {
      if (floors.isNotEmpty) {
        emit(state.copyWith(status: FloorStatus.success, floors: floors));
        print("JANET 2");
      } else {
        emit(state.copyWith(status: FloorStatus.empty));
        print("JANET 3");
      }
      print("JON MARK 2");
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: FloorStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
        print("JON MARK 3");
      }
    });
  }

  _mapAddFloorEventToState(
      AddFloorEvent event, Emitter<FloorState> emit) async {
    emit(state.copyWith(status: FloorStatus.loadingAdd, isFloorLoading: true));
    await FloorDtoImpl.addFloor(currentUserToken.toString(), event.propertyId,
            event.floorName, event.description)
        .then((response) {
      print('success ${response.floorCreatedViaApi}');

      if (response != null) {
        emit(state.copyWith(
            status: FloorStatus.successAdd,
            isFloorLoading: false,
            floorResponseModel: response));
      } else {
        emit(state.copyWith(
          status: FloorStatus.accessDeniedAdd,
          isFloorLoading: false,
        ));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          status: FloorStatus.errorAdd,
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
  void onEvent(FloorEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<FloorEvent, FloorState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onChange(Change<FloorState> change) {
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
