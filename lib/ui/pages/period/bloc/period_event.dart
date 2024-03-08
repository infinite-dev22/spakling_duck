part of 'period_bloc.dart';

abstract class PeriodEvent extends Equatable {
  const PeriodEvent();
}

class LoadAllPeriodsEvent extends PeriodEvent {
  final int id;
  const LoadAllPeriodsEvent( this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
