part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
}


class LoadAllPayments extends PaymentEvent{
  final int propertyId;
  const LoadAllPayments( this.propertyId);
  @override
  // TODO: implement props
  List<Object?> get props => [propertyId];

}

class AddPaymentsEvent extends PaymentEvent {
  final String token;
  final String paid;
  final String amountDue;
  final String date;
  final int tenantUnitId;
  final int accountId;
  final int paymentModeId;
  final int propertyId;
  final List<String> paymentScheduleId;

  const AddPaymentsEvent(this.token, this.paid, this.amountDue, this.date,
      this.tenantUnitId, this.accountId, this.paymentModeId, this.propertyId,
      this.paymentScheduleId);

  @override
  // TODO: implement props
  List<Object?> get props => [token, paid, amountDue, date, tenantUnitId,
    accountId, paymentModeId, propertyId, paymentScheduleId
  ];

}