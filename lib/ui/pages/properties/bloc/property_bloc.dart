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
    on<LoadPropertiesEvent>(_mapFetchPropertiesToState);
    on<LoadSinglePropertyEvent>(_mapViewSinglePropertyDetailsEventToState);
    on<AddPropertyEvent>(_mapAddPropertyEventToState);

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
        print("Error: $error");
        print("Stacktrace: $stackTrace");
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

  _mapAddPropertyEventToState(
      AddPropertyEvent event, Emitter<PropertyState> emit) async {
    emit(state.copyWith(
        status: PropertyStatus.loadingAdd, isPropertyLoading: true));
    await PropertyDtoImpl.addProperty(
        currentUserToken.toString(),
        event.name,
        event.location,
        event.sqm,
        event.description,
        event.propertyTypeId,
        event.propertyCategoryId)
        .then((response) async{
      print('success ${response.propertyCreatedViaApi}');

      if (response != null) {

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
            print("Error: $error");
            print("Stacktrace: $stackTrace");
          }
        }).then((value) {
          emit(state.copyWith(
              status: PropertyStatus.successAdd,
              isPropertyLoading: false,
              addPropertyResponseModel: response));
        });


      } else {
        emit(state.copyWith(
          status: PropertyStatus.accessDeniedAdd,
          isPropertyLoading: false,
        ));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          status: PropertyStatus.errorDetails,
          isPropertyLoading: false,
          message: error.toString()));
    });
  }





  @override
  void onEvent(PropertyEvent event) {
    print(event);
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<PropertyEvent, PropertyState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  void onChange(Change<PropertyState> change) {
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
