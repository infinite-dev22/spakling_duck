import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_layer/dtos/implementation/unit_dto_impl.dart';
import 'package:smart_rent/data_layer/models/unit/add_unit_response.dart';
import 'package:smart_rent/data_layer/models/unit/unit_model.dart';
import 'package:smart_rent/data_layer/models/unit/unit_type_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/unit_repo_impl.dart';
import 'package:smart_rent/utilities/app_init.dart';

part 'unit_event.dart';part 'unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  UnitBloc() : super(const UnitState()) {
    on<LoadAllUnitsEvent>(_mapFetchUnitsToState);
    on<LoadUnitTypesEvent>(_mapFetchUnitTypesToState);
    on<AddUnitEvent>(_mapAddUnitEventToState);
  }

  _mapFetchUnitsToState(
      LoadAllUnitsEvent event, Emitter<UnitState> emit) async {
    emit(state.copyWith(status: UnitStatus.loading));
    await UnitRepoImpl()
        .getALlUnits(currentUserToken.toString(), event.id)
        .then((units) {
      if (units.isNotEmpty) {
        emit(state.copyWith(status: UnitStatus.success, units: units));
      } else {
        emit(state.copyWith(status: UnitStatus.empty));
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
      emit(state.copyWith(status: UnitStatus.error));
    });
  }

  _mapFetchUnitTypesToState(
      LoadUnitTypesEvent event, Emitter<UnitState> emit) async {
    emit(state.copyWith(status: UnitStatus.loadingUT));
    await UnitRepoImpl()
        .getUnitTypes(currentUserToken.toString(), event.id)
        .then((types) {
      if (types.isNotEmpty) {
        emit(state.copyWith(status: UnitStatus.successUT, unitTypes: types));
      } else {
        emit(state.copyWith(status: UnitStatus.emptyUT));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: UnitStatus.errorUT));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }

  _mapAddUnitEventToState(AddUnitEvent event, Emitter<UnitState> emit) async {
    emit(state.copyWith(status: UnitStatus.loadingAdd, isLoading: true));
    await UnitDtoImpl.addUnitToProperty(
      currentUserToken.toString(),
      event.unitTypeId,
      event.floorId,
      event.name,
      event.sqm,
      event.periodId,
      event.currencyId,
      event.initialAmount,
      event.description,
      event.propertyId,
    ).then((response) {
      print('success ${response.unitApi}');

      if (response != null) {
        emit(state.copyWith(
            status: UnitStatus.successAdd,
            isLoading: false,
            addUnitResponse: response));
      } else {
        emit(state.copyWith(
          status: UnitStatus.accessDeniedAdd,
          isLoading: false,
        ));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          status: UnitStatus.errorAdd,
          isLoading: false,
          message: error.toString()));
    });
  }

  @override
  void onEvent(UnitEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<UnitEvent, UnitState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onChange(Change<UnitState> change) {
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
