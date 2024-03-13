import 'package:flutter/material.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/custom_image.dart';

class SmartErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;

  const SmartErrorWidget({
    super.key,
    required this.message,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(
              'assets/images/error.png',
              isNetwork: false,
              radius: 0,
              width: size.width * .3,
              height: size.height * .3,
              imageFit: BoxFit.contain,
              isElevated: false,
            ),
            Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.inActiveColor,
              ),
            ),
            const Text(
              "Click the \"+\" button to add tenant units",
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.inActiveColor,
              ),
            ),
            const Text(
              "Or click the refresh button to refresh",
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.inActiveColor,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(onPressed: onPressed, child: Icon(Icons.refresh))
          ],
        ),
      );
    });
  }
}
