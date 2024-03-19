import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_layer/models/tenant_unit/add_tenant_unit_response.dart';
import 'package:smart_rent/data_layer/models/tenant_unit/tenant_unit_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/tenant_unit_repo_impl.dart';
import 'package:smart_rent/utilities/app_init.dart';

part 'tenant_unit_event.dart';
part 'tenant_unit_state.dart';

class TenantUnitBloc extends Bloc<TenantUnitEvent, TenantUnitState> {
  TenantUnitBloc() : super(const TenantUnitState()) {
    on<LoadTenantUnitsEvent>(_mapFetchTenantUnitsToState);
    on<RefreshTenantUnitsEvent>(_mapRefreshTenantUnitsToState);
  }

  _mapFetchTenantUnitsToState(
      LoadTenantUnitsEvent event, Emitter<TenantUnitState> emit) async {
    emit(state.copyWith(status: TenantUnitStatus.loading));
    await TenantUnitRepoImpl()
        .getALlTenantUnits(currentUserToken.toString(), event.id)
        .then((tenantUnits) {
      if (tenantUnits.isNotEmpty) {
        emit(state.copyWith(
            status: TenantUnitStatus.success, tenantUnits: tenantUnits));
      } else {
        emit(state.copyWith(status: TenantUnitStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: TenantUnitStatus.error));
      if (kDebugMode) {
        log("Error: $error");
        log("Stacktrace: $stackTrace");
      }
    });
  }

  _mapRefreshTenantUnitsToState(
      RefreshTenantUnitsEvent event, Emitter<TenantUnitState> emit) async {
    await TenantUnitRepoImpl()
        .getALlTenantUnits(currentUserToken.toString(), event.id)
        .then((tenantUnits) {
      if (tenantUnits.isNotEmpty) {
        emit(state.copyWith(
            status: TenantUnitStatus.success, tenantUnits: tenantUnits));
      } else {
        emit(state.copyWith(status: TenantUnitStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: TenantUnitStatus.error));
      if (kDebugMode) {
        log("Error: $error");
        log("Stacktrace: $stackTrace");
      }
    });
  }

  @override
  void onEvent(TenantUnitEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<TenantUnitEvent, TenantUnitState> transition) {
    log(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onChange(Change<TenantUnitState> change) {
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
