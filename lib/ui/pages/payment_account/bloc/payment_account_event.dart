part of 'payment_account_bloc.dart';

abstract class PaymentAccountEvent extends Equatable {
  const PaymentAccountEvent();
}

class LoadAllPaymentAccountsEvent extends PaymentAccountEvent {
  final int propertyId;
  const LoadAllPaymentAccountsEvent(this.propertyId);
  @override
  // TODO: implement props
  List<Object?> get props => [propertyId];

}
