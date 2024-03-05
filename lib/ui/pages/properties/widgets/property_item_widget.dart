import 'package:flutter/material.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/custom_image.dart';

class PropertyItemWidget extends StatelessWidget {
  const PropertyItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Container(
      // width: width,
      // height: height,
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: .1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        // children: [CustomImage(file)],
      ),
    );
  }
}
