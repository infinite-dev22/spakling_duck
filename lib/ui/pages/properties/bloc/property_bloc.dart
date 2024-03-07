import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'property_event.dart';
part 'property_state.dart';

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  PropertyBloc() : super(PropertyInitial()) {
    on<PropertyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
