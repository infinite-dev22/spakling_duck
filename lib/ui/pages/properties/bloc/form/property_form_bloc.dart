import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_rent/data_layer/dtos/implementation/property_dto_impl.dart';
import 'package:smart_rent/data_layer/models/property/add_response_model.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/data_layer/repositories/implementation/property_repo_impl.dart';
import 'package:smart_rent/utilities/app_init.dart';

part 'property_form_event.dart';
part 'property_form_state.dart';

class PropertyFormBloc extends Bloc<PropertyFormEvent, PropertyFormState> {
  PropertyFormBloc() : super(const PropertyFormState()) {
    on<LoadPropertiesEvent>(_mapFetchPropertiesToState);
    on<LoadSinglePropertyFormEvent>(_mapViewSinglePropertyDetailsEventToState);
    on<AddPropertyEvent>(_mapAddPropertyEventToState);
  }

  _mapFetchPropertiesToState(
      LoadPropertiesEvent event, Emitter<PropertyFormState> emit) async {
    emit(state.copyWith(status: PropertyFormStatus.loading));
    await PropertyRepoImpl()
        .getALlProperties(currentUserToken.toString())
        .then((properties) {
      if (properties.isNotEmpty) {
        emit(state.copyWith(
            status: PropertyFormStatus.success, properties: properties));
      } else {
        emit(state.copyWith(status: PropertyFormStatus.empty));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: PropertyFormStatus.error));
      if (kDebugMode) {
        log("Error: $error");
        log("Stacktrace: $stackTrace");
      }
    });
  }

  _mapViewSinglePropertyDetailsEventToState(LoadSinglePropertyFormEvent event,
      Emitter<PropertyFormState> emit) async {
    emit(state.copyWith(
      status: PropertyFormStatus.loadingDetails,
    ));
    await PropertyRepoImpl()
        .getSingleProperty(event.id, currentUserToken.toString())
        .then((property) async {
      if (property != null) {
        emit(state.copyWith(
            status: PropertyFormStatus.successDetails, property: property));
      } else {
        emit(state.copyWith(
            status: PropertyFormStatus.emptyDetails, property: null));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          status: PropertyFormStatus.errorDetails, isPropertyLoading: false));
    });
  }

  _mapAddPropertyEventToState(
      AddPropertyEvent event, Emitter<PropertyFormState> emit) async {
    emit(state.copyWith(
        status: PropertyFormStatus.loadingAdd, isPropertyLoading: true));
    await PropertyDtoImpl.addProperty(
            currentUserToken.toString(),
            event.name,
            event.location,
            event.sqm,
            event.description,
            event.propertyTypeId,
            event.propertyCategoryId)
        .then((response) async {
      log('success ${response.propertyCreatedViaApi}');

      if (response != null) {
        await PropertyRepoImpl()
            .getALlProperties(currentUserToken.toString())
            .then((properties) {
          if (properties.isNotEmpty) {
            emit(state.copyWith(
                status: PropertyFormStatus.success, properties: properties));
          } else {
            emit(state.copyWith(status: PropertyFormStatus.empty));
          }
        }).onError((error, stackTrace) {
          emit(state.copyWith(status: PropertyFormStatus.error));
          if (kDebugMode) {
            log("Error: $error");
            log("Stacktrace: $stackTrace");
          }
        }).then((value) {
          emit(state.copyWith(
              status: PropertyFormStatus.successAdd,
              isPropertyLoading: false,
              addPropertyResponseModel: response));
        });
      } else {
        emit(state.copyWith(
          status: PropertyFormStatus.accessDeniedAdd,
          isPropertyLoading: false,
        ));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          status: PropertyFormStatus.errorDetails,
          isPropertyLoading: false,
          message: error.toString()));
    });
  }

  @override
  void onEvent(PropertyFormEvent event) {
    log(event.toString());
    super.onEvent(event);
  }

  @override
  void onTransition(
      Transition<PropertyFormEvent, PropertyFormState> transition) {
    log(transition.toString());
    super.onTransition(transition);
  }

  @override
  void onChange(Change<PropertyFormState> change) {
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
