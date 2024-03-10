part of 'payment_schedules_bloc.dart';

abstract class PaymentSchedulesEvent extends Equatable {
  const PaymentSchedulesEvent();
}

 class LoadAllPaymentSchedulesEvent extends PaymentSchedulesEvent {
  final int tenantUnitId;
  final int propertyId;

  const LoadAllPaymentSchedulesEvent(this.tenantUnitId, this.propertyId);
  @override
  List<Object?> get props => [tenantUnitId, propertyId];

}
