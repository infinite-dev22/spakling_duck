part of 'property_bloc.dart';

abstract class PropertyState extends Equatable {
  const PropertyState();
}

class PropertyInitial extends PropertyState {
  @override
  List<Object> get props => [];
}
