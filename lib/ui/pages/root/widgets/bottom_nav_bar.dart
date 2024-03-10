import 'package:SmartCase/ui/pages/root/bloc/nav_bar_bloc.dart';
import 'package:SmartCase/ui/pages/root/widgets/bottom_bar_item.dart';
import 'package:SmartCase/ui/pages/root/widgets/screen.dart';
import 'package:SmartCase/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BottomNavBar extends StatelessWidget {
  final Function()? onFabTap;
  final List<Screen> screens;

  const BottomNavBar({
    super.key,
    required this.screens,
    this.onFabTap,
  });

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocBuilder<NavBarBloc, NavBarState>(
      builder: (context, state) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: context.read<NavBarBloc>().state.isVisible ? 1 : 0.5,
          child: LayoutBuilder(builder: (context, constraint) {
            return Container(
              height: 70,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size(constraint.maxWidth, 70),
                    painter: MyCustomPainter(),
                  ),
                  Center(
                    heightFactor: .6,
                    child: FloatingActionButton(
                      onPressed: onFabTap,
                      backgroundColor: AppTheme.primary,
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.add,
                        color: AppTheme.whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(
                        screens.length,
                        (index) => screens[index].icon == null
                            ? Container(
                                width: size.width * .2,
                              )
                            : BottomBarItem(
                                key: ValueKey('${screens[index].name}$index'),
                                screen: screens[index],
                                onTap: () {
                                  context
                                      .read<NavBarBloc>()
                                      .add(SwitchScreenEvent(index));
                                },
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    var path = Path()..moveTo(0, size.height * .25);

    path.quadraticBezierTo(0, 0, size.width * .05, 0);
    path.lineTo(size.width * .20, 0);
    path.quadraticBezierTo(size.width * .20, 0, size.width * .35, 0);
    path.quadraticBezierTo(size.width * .40, 0, size.width * .40, 20);
    path.arcToPoint(Offset(size.width * .60, 20),
        radius: const Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * .60, 0, size.width * .65, 0);
    path.lineTo(size.width * .95, 0);
    path.quadraticBezierTo(size.width, 0, size.width, size.height * .25);
    path.lineTo(size.width, size.height * .75);
    path.quadraticBezierTo(
        size.width, size.height, size.width * .95, size.height);
    path.lineTo(size.width * .05, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height * .75);
    path.lineTo(0, size.height * .05);
    path.close();

    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
