import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/ui/pages/units/forms/add_unit_form.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';

class UnitsSuccessScreen extends StatelessWidget {
  final Property property;

  const UnitsSuccessScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "add_unit",
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 25,
          ),
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
