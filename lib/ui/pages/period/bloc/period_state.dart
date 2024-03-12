part of 'period_bloc.dart';

enum PeriodStatus {
  initial,
  loading,
  success,
  error,
  empty,
  accessDenied,
  durationSelected,
}

extension PeriodStatusX on PeriodStatus {
  bool get isInitial => this == PeriodStatus.initial;

  bool get isLoading => this == PeriodStatus.loading;

  bool get isSuccess => this == PeriodStatus.success;

  bool get isError => this == PeriodStatus.error;

  bool get isEmpty => this == PeriodStatus.empty;

  bool get isAccessDenied => this == PeriodStatus.accessDenied;

  bool get isDurationSelected => this == PeriodStatus.durationSelected;
}

@immutable
class PeriodState extends Equatable {
  final List<PeriodModel> periods;
  final int? durationIdSelected;
  final PeriodStatus status;

  const PeriodState({
    this.status = PeriodStatus.initial,
    this.durationIdSelected,
    List<PeriodModel>? periods,
  }) : periods = periods ?? const [];

  @override
  // TODO: implement props
  List<Object?> get props => [periods, durationIdSelected, status];

  PeriodState copyWith({
    List<PeriodModel>? periods,
    int? durationIdSelected,
    PeriodStatus? status,
  }) {
    return PeriodState(
      periods: periods ?? this.periods,
      durationIdSelected: durationIdSelected ?? this.durationIdSelected,
      status: status ?? this.status,
    );
  }
}

class PeriodInitial extends PeriodState {
  @override
  List<Object> get props => [];
}
