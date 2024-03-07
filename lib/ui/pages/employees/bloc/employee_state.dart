part of 'employee_bloc.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();
}

class EmployeeInitial extends EmployeeState {
  @override
  List<Object> get props => [];
}
