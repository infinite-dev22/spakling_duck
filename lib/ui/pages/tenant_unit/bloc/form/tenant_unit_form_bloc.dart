import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_layer/dtos/implementation/tenant_unit_dto_impl.dart';
import 'package:smart_rent/data_layer/models/tenant_unit/add_tenant_unit_response.dart';
import 'package:smart_rent/data_layer/models/tenant_unit/tenant_unit_model.dart';
import 'package:smart_rent/utilities/app_init.dart';

part 'tenant_unit_form_event.dart';
part 'tenant_unit_form_state.dart';

class TenantUnitFormBloc
    extends Bloc<TenantUnitFormEvent, TenantUnitFormState> {
  TenantUnitFormBloc() : super(const TenantUnitFormState()) {
    on<AddTenantUnitEvent>(_mapAddTenantUnitFormEventToState);
  }

  _mapAddTenantUnitFormEventToState(
      AddTenantUnitEvent event, Emitter<TenantUnitFormState> emit) async {
    emit(state.copyWith(status: TenantUnitFormStatus.loading, isLoading: true));
    await TenantUnitDtoImpl.addTenantUnit(
      currentUserToken.toString(),
      event.tenantId,
      event.unitId,
      event.periodId,
      event.duration,
      event.fromDate,
      event.toDate,
      event.unitAmount,
      event.currencyId,
      event.agreedAmount,
      event.description,
      event.propertyId,
    ).then((response) {
      print('success ${response.tenantunitcreated}');

      if (response.tenantunitcreated != null) {
        emit(state.copyWith(
            status: TenantUnitFormStatus.success,
            isLoading: false,
            addTenantUnitResponse: response));
        print('Add Tenant Unit success ==  ${response.tenantunitcreated}');
      } else if (response.message != null) {
        emit(state.copyWith(
            status: TenantUnitFormStatus.error,
            isLoading: false,
            addTenantUnitResponse: response,
            message: response.message.toString()));
        print('Add Tenant Unit failed ==  ${response.message}');
      } else {
        emit(state.copyWith(
          status: TenantUnitFormStatus.accessDenied,
          isLoading: false,
        ));
      }
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      emit(state.copyWith(
          status: TenantUnitFormStatus.error,
          isLoading: false,
          message: error.toString()));
    });
  }

  @override
  void onEvent(TenantUnitFormEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onTransition(
      Transition<TenantUnitFormEvent, TenantUnitFormState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onChange(Change<TenantUnitFormState> change) {
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
