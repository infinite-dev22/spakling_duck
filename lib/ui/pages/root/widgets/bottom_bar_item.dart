import 'package:smart_rent/ui/pages/root/bloc/nav_bar_bloc.dart';
import 'package:smart_rent/ui/pages/root/widgets/screen.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BottomBarItem extends StatelessWidget {
  final Screen screen;
  final GestureTapCallback? onTap;

  const BottomBarItem({
    super.key,
    this.onTap,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarBloc, NavBarState>(
      bloc: NavBarBloc(),
      builder: (context, state) {
        return GestureDetector(
          onTap: onTap,
          child: BlocSelector<NavBarBloc, NavBarState, bool>(
            selector: (state) =>
                (state.status.isChanged && state.idSelected == screen.index)
                    ? true
                    : false,
            builder: (context, state) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOutCirc,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            color: state
                                ? AppTheme.primary.withOpacity(.1)
                                : Colors.transparent,
                          ),
                          child: Icon(
                            screen.icon,
                            size: 25,
                            color: state
                                ? AppTheme.primary
                                : AppTheme.inActiveColor,
                          ),
                        ),
                        Positioned(
                          bottom: -8,
                          child: Icon(
                            Icons.arrow_drop_up,
                            size: 20.0,
                            color:
                                state ? AppTheme.primary : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      screen.name!,
                      style: TextStyle(
                        color:
                            state ? AppTheme.primary : AppTheme.inActiveColor,
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
