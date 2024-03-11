part of 'period_bloc.dart';

abstract class PeriodEvent extends Equatable {
  const PeriodEvent();
}

class LoadAllPeriodsEvent extends PeriodEvent {
  final int id;

  const LoadAllPeriodsEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class SelectPeriodEvent extends PeriodEvent {
  final int durationIdSelected;

  const SelectPeriodEvent(this.durationIdSelected);

  @override
  List<Object?> get props => [durationIdSelected];
}
