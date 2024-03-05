part of 'nav_bar_bloc.dart';

abstract class NavBarEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const NavBarEvent();
}

class SwitchScreenEvent extends NavBarEvent {
  final int selectedIndex;

  @override
  List<Object?> get props => [
        selectedIndex,
      ];

  const SwitchScreenEvent(this.selectedIndex);
}
