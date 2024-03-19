part of 'floor_bloc.dart';

enum FloorStatus {
  initial,
  success,
  loading,
  accessDenied,
  error,
  empty,
  notFound,
}

extension FloorStatusX on FloorStatus {
  bool get isInitial => this == FloorStatus.initial;

  bool get isSuccess => this == FloorStatus.success;

  bool get isError => this == FloorStatus.error;

  bool get isLoading => this == FloorStatus.loading;

  bool get isEmpty => this == FloorStatus.empty;

  bool get isNotFound => this == FloorStatus.notFound;
}

@immutable
class FloorState extends Equatable {
  final List<FloorModel>? floors;
  final FloorStatus status;
  final FloorModel? floorModel;
  final AddFloorResponseModel? floorResponseModel;
  final String? message;

  const FloorState({
    this.floors,
    this.status = FloorStatus.initial,
    this.floorModel,
    this.floorResponseModel,
    this.message = '',
  });

  FloorState copyWith({
    List<FloorModel>? floors,
    FloorStatus? status,
    FloorModel? floorModel,
    AddFloorResponseModel? floorResponseModel,
    bool? isFloorLoading,
    String? message,
  }) {
    return FloorState(
        floors: floors ?? this.floors,
        status: status ?? this.status,
        floorModel: floorModel ?? this.floorModel,
        floorResponseModel: floorResponseModel ?? this.floorResponseModel,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [
        floors,
        status,
        floorModel,
        floorResponseModel,
        message,
      ];
}
