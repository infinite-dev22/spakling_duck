import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_layer/dtos/implementation/tenant_unit_dto_impl.dart';
import 'package:smart_rent/data_layer/models/payment/payment_schedules_model.dart';
import 'package:smart_rent/data_layer/models/tenant_unit/add_tenant_unit_response.dart';
import 'package:smart_rent/data_layer/models/tenant_unit/tenant_unit_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/tenant_unit_repo_impl.dart';
import 'package:smart_rent/ui/pages/tenant_unit/bloc/form/tenant_unit_form_bloc.dart';
import 'package:smart_rent/utilities/app_init.dart';

part 'tenant_unit_event.dart';part 'tenant_unit_state.dart';

class TenantUnitBloc extends Bloc<TenantUnitEvent, TenantUnitState> {
  TenantUnitBloc() : super(const TenantUnitState()) {
    on<LoadTenantUnitsEvent>(_mapFetchTenantUnitsToState);
    on<RefreshTenantUnitsEvent>(_mapRefreshTenantUnitsToState);
    on<LoadTenantUnitPaymentSchedules>(_mapFetchTenantUnitPaymentSchedulesToState);
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
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }

  _mapFetchTenantUnitPaymentSchedulesToState(
      LoadTenantUnitPaymentSchedules event, Emitter<TenantUnitState> emit) async {
    emit(state.copyWith(status: TenantUnitStatus.loadingDetails));
    await TenantUnitRepoImpl()
        .getALlTenantUnitSchedules(currentUserToken.toString(), event.tenantUnitId)
        .then((tenantUnitSchedules) {
      if (tenantUnitSchedules.isNotEmpty) {
        emit(state.copyWith(
            status: TenantUnitStatus.successDetails, paymentSchedules: tenantUnitSchedules));
      } else {
        emit(state.copyWith(status: TenantUnitStatus.emptyDetails));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: TenantUnitStatus.errorDetails, message: error.toString()));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
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
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }

  @override
  void onEvent(TenantUnitEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<TenantUnitEvent, TenantUnitState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onChange(Change<TenantUnitState> change) {
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
