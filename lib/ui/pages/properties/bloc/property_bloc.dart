import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_layer/dtos/implementation/property_dto_impl.dart';
import 'package:smart_rent/data_layer/models/property/add_response_model.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/property_repo_impl.dart';
import 'package:smart_rent/utilities/app_init.dart';

part 'property_event.dart';
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  PropertyBloc() : super(const PropertyState()) {
    on<RefreshPropertiesEvent>(_mapRefreshPropertiesToState);
    on<LoadPropertiesEvent>(_mapFetchPropertiesToState);
    on<LoadSinglePropertyEvent>(_mapViewSinglePropertyDetailsEventToState);
  }

  _mapRefreshPropertiesToState(
      RefreshPropertiesEvent event, Emitter<PropertyState> emit) async {
    await PropertyRepoImpl()
        .getALlProperties(currentUserToken.toString())
        .then((properties) {
      if (properties.isNotEmpty) {
        emit(state.copyWith(
            status: PropertyStatus.success, properties: properties));
      } else {
        emit(state.copyWith(status: PropertyStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: PropertyStatus.error));
      if (kDebugMode) {
        log("Error: $error");
        log("Stacktrace: $stackTrace");
      }
    });
  }

  _mapFetchPropertiesToState(
      LoadPropertiesEvent event, Emitter<PropertyState> emit) async {
    emit(state.copyWith(status: PropertyStatus.loading));
    await PropertyRepoImpl()
        .getALlProperties(currentUserToken.toString())
        .then((properties) {
      if (properties.isNotEmpty) {
        emit(state.copyWith(
            status: PropertyStatus.success, properties: properties));
      } else {
        emit(state.copyWith(status: PropertyStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: PropertyStatus.error));
      if (kDebugMode) {
        log("Error: $error");
        log("Stacktrace: $stackTrace");
      }
    });
  }

  _mapViewSinglePropertyDetailsEventToState(
      LoadSinglePropertyEvent event, Emitter<PropertyState> emit) async {
    emit(state.copyWith(
      status: PropertyStatus.loadingDetails,
    ));
    await PropertyRepoImpl()
        .getSingleProperty(event.id, currentUserToken.toString())
        .then((property) async {
      if (property != null) {
        emit(state.copyWith(
            status: PropertyStatus.successDetails, property: property));
      } else {
        emit(state.copyWith(
            status: PropertyStatus.emptyDetails, property: null));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          status: PropertyStatus.errorDetails, isPropertyLoading: false));
    });
  }

  @override
  void onEvent(PropertyEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<PropertyEvent, PropertyState> transition) {
    log(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onChange(Change<PropertyState> change) {
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
