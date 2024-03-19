import 'dart:async';
import 'dart:developer';

import 'package:smart_rent/data_layer/dtos/implementation/unit_dto_impl.dart';
import 'package:smart_rent/data_layer/models/unit/add_unit_response.dart';
import 'package:smart_rent/data_layer/models/unit/unit_model.dart';
import 'package:smart_rent/data_layer/models/unit/unit_type_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/unit_repo_impl.dart';
import 'package:smart_rent/utilities/app_init.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';



part 'unit_form_event.dart';
part 'unit_form_state.dart';

class UnitFormBloc extends Bloc<UnitFormEvent, UnitFormState> {
  UnitFormBloc() : super(const UnitFormState()) {
    on<LoadUnitTypesEvent>(_mapFetchUnitTypesToState);
    on<AddUnitEvent>(_mapAddUnitEventToState);
  }

  _mapFetchUnitTypesToState(
      LoadUnitTypesEvent event, Emitter<UnitFormState> emit) async {
    emit(state.copyWith(status: UnitFormStatus.loadingUT));
    await UnitRepoImpl()
        .getUnitTypes(currentUserToken.toString(), event.id)
        .then((types) {
      if (types.isNotEmpty) {
        emit(state.copyWith(status: UnitFormStatus.successUT, unitTypes: types));
      } else {
        emit(state.copyWith(status: UnitFormStatus.emptyUT));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: UnitFormStatus.errorUT));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
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


  _mapAddUnitEventToState(
      AddUnitEvent event, Emitter<UnitFormState> emit) async {
    emit(state.copyWith(status: UnitFormStatus.loading, isLoading: true));
    await UnitDtoImpl.addUnitToProperty(currentUserToken.toString(),
         event.unitTypeId, event.floorId, event.name, event.sqm,
        event.periodId, event.currencyId, event.initialAmount, event.description, event.propertyId,
    )
        .then((response) {
      print('success ${response.unitApi}');

      if (response != null) {
        emit(state.copyWith(
            status: UnitFormStatus.success,
            isLoading: false,
            addUnitResponse: response));

      } else {
        emit(state.copyWith(
          status: UnitFormStatus.accessDenied,
          isLoading: false,
        ));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          status: UnitFormStatus.error,
          isLoading: false,
          message: error.toString()));
    });
  }

  @override
  void onEvent(UnitFormEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<UnitFormEvent, UnitFormState> transition) {
    log(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onChange(Change<UnitFormState> change) {
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
