part of 'payment_schedules_bloc.dart';

enum PaymentSchedulesStatus { initial, loading, success, empty, error, accessDenied,
  loadingAdd, successAdd, emptyAdd, errorAdd, accessDeniedAdd
}

 class PaymentSchedulesState extends Equatable {
  // final List<PaymentSchedulesModel>? paymentSchedules;
  final List<PaymentTenantUnitScheduleModel>? paymentSchedules;
  final PaymentSchedulesStatus status;
  const PaymentSchedulesState({
    this.paymentSchedules,
    this.status = PaymentSchedulesStatus.initial
 });

  @override
  List<Object?> get props => [paymentSchedules, status];

  PaymentSchedulesState copyWith({
     // List<PaymentSchedulesModel>? paymentSchedules,
     List<PaymentTenantUnitScheduleModel>? paymentSchedules,
     PaymentSchedulesStatus? status,
 }) {
    return PaymentSchedulesState(
      paymentSchedules: paymentSchedules ?? this.paymentSchedules,
      status: status ?? this.status,
    );
  }

}

class PaymentSchedulesInitial extends PaymentSchedulesState {
  @override
  List<Object> get props => [];
}
