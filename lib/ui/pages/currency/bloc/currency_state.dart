part of 'currency_bloc.dart';

enum CurrencyStatus { initial, loading, success, empty, error, accessDenied }

extension CurrencyStatusX on CurrencyStatus {
  bool get isInitial => this == CurrencyStatus.initial;

  bool get isLoading => this == CurrencyStatus.loading;

  bool get isSuccess => this == CurrencyStatus.success;

  bool get isError => this == CurrencyStatus.error;

  bool get isEmpty => this == CurrencyStatus.empty;

  bool get isAccessDenied => this == CurrencyStatus.accessDenied;
}

class CurrencyState extends Equatable {
  final List<CurrencyModel> currencies;
  final CurrencyStatus status;

  const CurrencyState({
    List<CurrencyModel>? currencies,
    this.status = CurrencyStatus.initial,
  }) : currencies = currencies ?? const [];

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
