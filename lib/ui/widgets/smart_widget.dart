import 'package:SmartCase/ui/widgets/custom_image.dart';
import 'package:flutter/material.dart';

class SmartWidget extends StatelessWidget {
  const SmartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: CustomImage(
            'assets/images/logo_dark.png',
            isNetwork: false,
            radius: 0,
            width: constraints.minWidth * .7,
            imageFit: BoxFit.contain,
            isElevated: false,
          ),
        );
      }
    );
  }
}
