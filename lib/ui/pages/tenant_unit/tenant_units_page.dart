import 'package:flutter/material.dart';
import 'package:smart_rent/ui/pages/tenant_unit/tenant_units_page_layout.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';

class TenantUnitsPage extends StatelessWidget {
  final Property property;

  const TenantUnitsPage({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return TenantUnitsPageLayout(property: property);
  }
}
