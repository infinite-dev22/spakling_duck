import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_layer/models/property/property_types_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/property_type_repo_impl.dart';
import 'package:smart_rent/utilities/app_init.dart';

part 'property_type_event.dart';part 'property_type_state.dart';

class PropertyTypeBloc extends Bloc<PropertyTypeEvent, PropertyTypeState> {
  PropertyTypeBloc() : super(PropertyTypeInitial()) {
    on<LoadAllPropertyTypesEvent>(_mapFetchPropertyTypesToState);
  }

  _mapFetchPropertyTypesToState(
      LoadAllPropertyTypesEvent event, Emitter<PropertyTypeState> emit) async {
    emit(state.copyWith(status: PropertyTypeStatus.loading));
    await PropertyTypeRepoImpl()
        .getALlPropertyTypes(currentUserToken.toString())
        .then((types) {
      if (types.isNotEmpty) {
        emit(state.copyWith(
            status: PropertyTypeStatus.success, propertyTypes: types));
      } else {
        emit(state.copyWith(status: PropertyTypeStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: PropertyTypeStatus.error));
      if (kDebugMode) {
        print("Error: $error");
        print("Stacktrace: $stackTrace");
      }
    });
  }
}
