part of 'unit_bloc.dart';

abstract class UnitEvent extends Equatable {
  const UnitEvent();
}

class LoadAllUnitsEvent extends UnitEvent {
  final int id;

  const LoadAllUnitsEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class RefreshUnitsEvent extends UnitEvent {
  final int id;

  const RefreshUnitsEvent(this.id);

  @override
  List<Object?> get props => [id];
}
