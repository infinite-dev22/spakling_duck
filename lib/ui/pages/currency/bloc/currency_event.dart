part of 'currency_bloc.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();
}

class LoadAllCurrenciesEvent extends CurrencyEvent {
  final int id;
  const LoadAllCurrenciesEvent(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
