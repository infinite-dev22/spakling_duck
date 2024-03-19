part of 'payment_form_bloc.dart';

enum PaymentFormStatus {
  initial,
  loading,
  success,
  empty,
  error,
  accessDenied,
}

extension PaymentFormStatusX on PaymentFormStatus {
  bool get isInitial => this == PaymentFormStatus.initial;

  bool get isSuccess => this == PaymentFormStatus.success;

  bool get isError => this == PaymentFormStatus.error;

  bool get isLoading => this == PaymentFormStatus.loading;

  bool get isEmpty => this == PaymentFormStatus.empty;
}

@immutable
class PaymentFormState extends Equatable {
  final List<PaymentsModel>? payments;
  final PaymentFormStatus status;
  final PaymentsModel? paymentsModel;
  final AddPaymentResponseModel? addPaymentResponseModel;
  final bool? isPaymentLoading;
  final String? message;

  const PaymentFormState(
      {this.payments,
      this.status = PaymentFormStatus.initial,
      this.paymentsModel,
      this.addPaymentResponseModel,
      this.isPaymentLoading = false,
      this.message = ''});

  @override
  // TODO: implement props
  List<Object?> get props => [
        payments,
        status,
        paymentsModel,
        addPaymentResponseModel,
        isPaymentLoading,
        message
      ];

  PaymentFormState copyWith({
    List<PaymentsModel>? payments,
    PaymentFormStatus? status,
    PaymentsModel? paymentsModel,
    AddPaymentResponseModel? addPaymentResponseModel,
    bool? isPaymentLoading,
    String? message,
  }) {
    return PaymentFormState(
        payments: payments ?? this.payments,
        status: status ?? this.status,
        paymentsModel: paymentsModel ?? this.paymentsModel,
        addPaymentResponseModel:
            addPaymentResponseModel ?? this.addPaymentResponseModel,
        isPaymentLoading: isPaymentLoading ?? this.isPaymentLoading,
        message: message ?? this.message);
  }
}
