part of 'payment_account_bloc.dart';


enum PaymentAccountStatus { initial, loading, success, empty, error, accessDenied }

 class PaymentAccountState extends Equatable {
  final List<PaymentAccountsModel>? paymentAccounts;
  final PaymentAccountStatus status;
  const PaymentAccountState({
    this.paymentAccounts,
    this.status = PaymentAccountStatus.initial
 });

  @override
  // TODO: implement props
  List<Object?> get props => [paymentAccounts, status];

  PaymentAccountState copyWith({
    List<PaymentAccountsModel>? paymentAccounts,
    PaymentAccountStatus? status,
  }) {
    return PaymentAccountState(
        paymentAccounts: paymentAccounts ?? this.paymentAccounts,
        status: status ?? this.status);
  }

}

class PaymentAccountInitial extends PaymentAccountState {
  @override
  List<Object> get props => [];
}
