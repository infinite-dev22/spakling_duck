part of 'period_bloc.dart';

enum PeriodStatus { initial, loading, success, error, empty, accessDenied }

@immutable
class PeriodState extends Equatable {
  final List<PeriodModel>? periods;
  final PeriodStatus? status;

  const PeriodState({this.periods, this.status = PeriodStatus.initial});

  @override
  // TODO: implement props
  List<Object?> get props => [periods, status];

  PeriodState copyWith({
    List<PeriodModel>? periods,
    PeriodStatus? status,
  }) {
    return PeriodState(
      periods: periods ?? this.periods,
      status: status ?? this.status,
    );
  }
}

class PeriodInitial extends PeriodState {
  @override
  List<Object> get props => [];
}
