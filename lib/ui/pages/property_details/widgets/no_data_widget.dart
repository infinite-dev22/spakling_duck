import 'package:SmartCase/ui/widgets/custom_image.dart';
import 'package:flutter/material.dart';


class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: CustomImage(
          'assets/images/no_data.png',
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
