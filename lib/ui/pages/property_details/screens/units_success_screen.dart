import 'package:flutter/material.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/ui/pages/units/forms/add_unit_form.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';

class UnitsSuccessScreen extends StatelessWidget {
  final Property property;

  const UnitsSuccessScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "add_unit",
        label: const Text(
          "Add Unit",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return AddUnitForm(
                addButtonText: 'Add',
                isUpdate: false,
                property: property,
              );
            }),
        backgroundColor: AppTheme.primary,
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
