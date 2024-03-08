part of 'currency_bloc.dart';

enum CurrencyStatus { initial, loading, success, empty, error, accessDenied }

class CurrencyState extends Equatable {
  final List<CurrencyModel>? currencies;
  final CurrencyStatus? status;

  const CurrencyState({this.currencies, this.status = CurrencyStatus.initial});

  @override
  // TODO: implement props
  List<Object?> get props => [currencies, status];

  CurrencyState copyWith({
    List<CurrencyModel>? currencies,
    CurrencyStatus? status,
  }) {
    return CurrencyState(
        currencies: currencies ?? this.currencies,
        status: status ?? this.status);
  }
}

class CurrencyInitial extends CurrencyState {
  @override
  List<Object> get props => [];
}
