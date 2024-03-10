part of 'payment_mode_bloc.dart';


abstract class PaymentModeEvent extends Equatable {
  const PaymentModeEvent();
}

class LoadAllPaymentModesEvent extends PaymentModeEvent {
  final int propertyId;
  const LoadAllPaymentModesEvent(this.propertyId);
  @override
  // TODO: implement props
  List<Object?> get props => [propertyId];

}