part of 'floor_form_bloc.dart';

enum FloorFormStatus {
  initial,
  success,
  loading,
  accessDenied,
  error,
  empty,
  notFound,
}

extension FloorFormStatusX on FloorFormStatus {
  bool get isInitial => this == FloorFormStatus.initial;

  bool get isSuccess => this == FloorFormStatus.success;

  bool get isError => this == FloorFormStatus.error;

  bool get isLoading => this == FloorFormStatus.loading;

  bool get isEmpty => this == FloorFormStatus.empty;

  bool get isNotFound => this == FloorFormStatus.notFound;
}

@immutable
class FloorFormState extends Equatable {
  final List<FloorModel>? floors;
  final FloorFormStatus status;
  final FloorModel? floorModel;
  final AddFloorResponseModel? floorResponseModel;
  final bool? isFloorLoading;
  final String? message;

  const FloorFormState({
    this.floors,
    this.status = FloorFormStatus.initial,
    this.floorModel,
    this.floorResponseModel,
    this.isFloorLoading = false,
    this.message = '',
  });

  FloorFormState copyWith({
    List<FloorModel>? floors,
    FloorFormStatus? status,
    FloorModel? floorModel,
    AddFloorResponseModel? floorResponseModel,
    bool? isFloorLoading,
    String? message,
  }) {
    return FloorFormState(
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
class FloorInitial extends FloorFormState {
  @override
  List<Object> get props => [];
}
