part of 'payment_bloc.dart';


enum PaymentStatus { initial, loading, success, empty, error, accessDenied,
  loadingAdd, successAdd, emptyAdd, errorAdd, accessDeniedAdd
}

 class PaymentState extends Equatable {
  final List<PaymentsModel>? payments;
  final PaymentStatus status;
  final PaymentsModel? paymentsModel;
  final AddPaymentResponseModel? addPaymentResponseModel;
  final bool? isPaymentLoading;
  final String? message;

  const PaymentState({
    this.payments,
    this.status = PaymentStatus.initial,
    this.paymentsModel,
    this.addPaymentResponseModel,
    this.isPaymentLoading = false,
    this.message = ''

 });

  @override
  // TODO: implement props
  List<Object?> get props => [payments, status, paymentsModel, addPaymentResponseModel,
    isPaymentLoading, message
  ];

  PaymentState copyWith({
     List<PaymentsModel>? payments,
     PaymentStatus? status,
     PaymentsModel? paymentsModel,
     AddPaymentResponseModel? addPaymentResponseModel,
     bool? isPaymentLoading,
     String? message,
 }) {
    return PaymentState(
      payments: payments ?? this.payments,
      status: status ?? this.status,
      paymentsModel: paymentsModel ?? this.paymentsModel,
      addPaymentResponseModel: addPaymentResponseModel ?? this.addPaymentResponseModel,
      isPaymentLoading: isPaymentLoading ?? this.isPaymentLoading,
      message: message ?? this.message
    );
  }

}

class PaymentInitial extends PaymentState {
  @override
  List<Object> get props => [];
}
