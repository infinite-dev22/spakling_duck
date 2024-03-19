part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
}

class LoadAllPayments extends PaymentEvent {
  final int propertyId;

  const LoadAllPayments(this.propertyId);

  @override
  List<Object?> get props => [propertyId];
}

class LoadPayments extends PaymentEvent {
  @override
  List<Object?> get props => [];
}

class RefreshPaymentsEvent extends PaymentEvent {
  final int propertyId;

  const RefreshPaymentsEvent(this.propertyId);

  @override
  List<Object?> get props => [propertyId];
}
