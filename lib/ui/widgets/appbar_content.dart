import 'package:flutter/material.dart';

class TitleBarImageHolder extends StatelessWidget {
  const TitleBarImageHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 35,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage('assets/images/title_bar_white.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
