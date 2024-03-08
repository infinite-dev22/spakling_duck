import 'package:flutter/material.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/ui/pages/property_details/widgets/property_details_layout.dart';

class PropertyDetailsPage extends StatelessWidget {
  const PropertyDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Property property =
        ModalRoute.of(context)!.settings.arguments as Property;
    return PropertyDetailsLayout(property: property);
  }
}
