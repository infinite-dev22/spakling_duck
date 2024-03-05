import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/custom_image.dart';

class PropertyItemWidget extends StatelessWidget {
  final Function()? onTap;

  const PropertyItemWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return GestureDetector(
      onTap: onTap,
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: ValueKey("property-item-widget-${Random().nextDouble()}"),
        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.transparent,
              foregroundColor: AppTheme.blue,
              icon: FontAwesome.pen_to_square,
            ),
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.transparent,
              foregroundColor: AppTheme.red,
              icon: FontAwesome.trash_can,
            ),
          ],
        ),
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
          child: const Row(
            children: [
              CustomImage(
                "assets/images/property_image.jpg",
                isNetwork: false,
                radius: 10,
                height: 200,
                width: 150,
              ),
              SizedBox(width: 10),
              PropertyDetails(),
            ],
          ),
        ),
      ),
    );
  }
}

class PropertyDetails extends StatelessWidget {
  const PropertyDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Property Name",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Property Location'),
            SizedBox(width: 10),
            Text('5,000 sqm'),
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
