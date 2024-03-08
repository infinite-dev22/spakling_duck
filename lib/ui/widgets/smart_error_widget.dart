import 'package:flutter/material.dart';
import 'package:smart_rent/ui/widgets/custom_image.dart';

class SmartErrorWidget extends StatelessWidget {
  const SmartErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: CustomImage(
          'assets/images/error.png',
          isNetwork: false,
          radius: 0,
          width: constraints.minWidth * .7,
          imageFit: BoxFit.contain,
          isElevated: false,
        ),
      );
    });
  }
}
