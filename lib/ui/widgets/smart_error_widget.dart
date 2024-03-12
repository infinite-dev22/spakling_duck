import 'package:flutter/material.dart';
import 'package:smart_rent/ui/widgets/custom_image.dart';

class SmartErrorWidget extends StatelessWidget {
  const SmartErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: CustomImage(
          'assets/images/error.png',
          isNetwork: false,
          radius: 0,
          width: size.width,
          height: size.height,
          imageFit: BoxFit.contain,
          isElevated: false,
        ),
      );
    });
  }
}
