part of 'payment_mode_bloc.dart';


enum PaymentModeStatus { initial, loading, success, empty, error, accessDenied }

 class PaymentModeState extends Equatable {
  final List<PaymentModeModel>? paymentModes;
  final PaymentModeStatus status;
  const PaymentModeState({
    this.paymentModes,
    this.status = PaymentModeStatus.initial
 });

  @override
  // TODO: implement props
  List<Object?> get props => [paymentModes, status];

  PaymentModeState copyWith({
     List<PaymentModeModel>? paymentModes,
     PaymentModeStatus? status,
 }) {
    return PaymentModeState(
      paymentModes: paymentModes ?? this.paymentModes,
      status: status ?? this.status
    );
  }

}

class PaymentModeInitial extends PaymentModeState {
  @override
  List<Object> get props => [];
}
