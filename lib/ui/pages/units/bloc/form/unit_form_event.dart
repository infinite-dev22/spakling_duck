part of 'unit_form_bloc.dart';

@immutable
abstract class UnitFormEvent extends Equatable {
  const UnitFormEvent();
}

class LoadUnitTypesEvent extends UnitFormEvent {
  final int id;

  const LoadUnitTypesEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddUnitEvent extends UnitFormEvent {
  final String token;
  final int unitTypeId;
  final int floorId;
  final String name;
  final String sqm;
  final int periodId;
  final int currencyId;
  final int initialAmount;
  final String description;
  final int propertyId;

  const AddUnitEvent(
      this.token,
      this.unitTypeId,
      this.floorId,
      this.name,
      this.sqm,
      this.periodId,
      this.currencyId,
      this.initialAmount,
      this.description,
      this.propertyId);

  @override
  // TODO: implement props
  List<Object?> get props => [
        token,
        unitTypeId,
        floorId,
        name,
        sqm,
        periodId,
        currencyId,
        initialAmount,
        description,
        propertyId
      ];
}
