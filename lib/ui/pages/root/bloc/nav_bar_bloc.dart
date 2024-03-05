import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_rent/ui/pages/root/widgets/screen.dart';

part 'nav_bar_event.dart';
part 'nav_bar_state.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  NavBarBloc() : super(const NavBarState()) {
    on<SwitchScreenEvent>(_mapSwitchScreenEventToState);
  }

  _mapSwitchScreenEventToState(
      SwitchScreenEvent event, Emitter<NavBarState> emit) {
    emit(state.copyWith(status: NavBarStatus.changing));
    emit(
      state.copyWith(
        status: NavBarStatus.changed,
        idSelected: event.selectedIndex,
      ),
    );
  }

  @override
  void onChange(Change<NavBarState> change) {
    super.onChange(change);
    if (kDebugMode) {
      print("Change: $change");
    }
  }

  @override
  void onEvent(NavBarEvent event) {
    super.onEvent(event);
    if (kDebugMode) {
      print("Event: $event");
    }
  }

  @override
  void onTransition(Transition<NavBarEvent, NavBarState> transition) {
    super.onTransition(transition);
    if (kDebugMode) {
      print("Transition: $transition");
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    if (kDebugMode) {
      print("Error: $error");
      print("StackTrace: $stackTrace");
    }
  }
}
