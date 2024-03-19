part of 'payment_form_bloc.dart';

@immutable
abstract class PaymentFormEvent extends Equatable {
  const PaymentFormEvent();
}

class AddPaymentsEvent extends PaymentFormEvent {
  final String token;
  final String paid;
  final String amountDue;
  final String date;
  final int tenantUnitId;
  final int accountId;
  final int paymentModeId;
  final int propertyId;
  final List<String> paymentScheduleId;

  const AddPaymentsEvent(
      this.token,
      this.paid,
      this.amountDue,
      this.date,
      this.tenantUnitId,
      this.accountId,
      this.paymentModeId,
      this.propertyId,
      this.paymentScheduleId);

  @override
  List<Object?> get props => [
        token,
        paid,
        amountDue,
        date,
        tenantUnitId,
        accountId,
        paymentModeId,
        propertyId,
        paymentScheduleId
      ];
}
