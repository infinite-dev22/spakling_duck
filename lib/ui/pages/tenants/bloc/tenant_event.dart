part of 'tenant_bloc.dart';

abstract class TenantEvent extends Equatable {
  const TenantEvent();
}

class LoadAllTenantsEvent extends TenantEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadSingleTenantEvent extends TenantEvent {
  final int id;

  const LoadSingleTenantEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class LoadTenantTypes extends TenantEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
