import 'dart:math';

import 'package:SmartCase/data_layer/models/property/property_response_model.dart';
import 'package:SmartCase/ui/themes/app_theme.dart';
import 'package:SmartCase/ui/widgets/custom_image.dart';
import 'package:flutter/material.dart';


class PropertyItemWidget extends StatelessWidget {
  final Property property;
  final Function()? onTap;

  const PropertyItemWidget({super.key, required this.property, this.onTap});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return GestureDetector(
      key: ValueKey(
          "property-item-widget-${Random().nextDouble()}-${property.name}-${property.description}"),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 15,
          left: 10,
          right: 10,
        ),
        // width: width,
        height: 200,
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
          children: [
            const CustomImage(
              "assets/images/property_image.jpg",
              isNetwork: false,
              radius: 10,
              height: 200,
              width: 150,
            ),
            SizedBox(width: 10),
            PropertyDetails(property: property),
          ],
        ),
      ),
    );
  }
}

class PropertyDetails extends StatelessWidget {
  final Property property;

  const PropertyDetails({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          property.name!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(property.location!),
            SizedBox(width: 10),
            Text('${property.squareMeters!} sqm'),
          ],
        ),
        Text('0 Units'),
        Text('Available - 0 Units'),
        Text('Occupied - 0 Units'),
        Text('200,000 / month'),
      ],
    );
  }
}
