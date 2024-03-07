part of 'floor_bloc.dart';

enum FloorStatus {
  initial,
  success,
  loading,
  accessDenied,
  error,
  empty,
  loadingDetails,
  successDetails,
  errorDetails,
  emptyDetails,
  successAdd,
  loadingAdd,
  accessDeniedAdd,
  errorAdd,
  emptyAdd
}

class FloorState extends Equatable {
  final List<FloorModel>? floors;
  final FloorStatus status;
  final FloorModel? floorModel;
  final AddFloorResponseModel? floorResponseModel;
  final bool? isFloorLoading;
  final String? message;

  const FloorState({
    this.floors,
    this.status = FloorStatus.initial,
    this.floorModel,
    this.floorResponseModel,
    this.isFloorLoading = false,
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
        isFloorLoading: isFloorLoading ?? this.isFloorLoading,
        message: message ?? this.message);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [floors, status, floorModel, floorResponseModel, isFloorLoading, message];
}

@immutable
class FloorInitial extends FloorState {
  @override
  List<Object> get props => [];
}
