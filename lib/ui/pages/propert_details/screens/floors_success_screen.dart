import 'package:flutter/material.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/ui/pages/propert_details/forms/floor/add_property_floor_form.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';

class FloorsSuccessScreen extends StatelessWidget {
  final Property property;
  const FloorsSuccessScreen({super.key, required this.property, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        splashColor: Colors.transparent,
        elevation: 0.0,
        heroTag: null,
        label: GestureDetector(
          onTap: () {
            showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return AddPropertyFloorForm(
                    addButtonText: 'Add',
                    isUpdate: false,
                    property: property,
                  );
                });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppTheme.primaryColor
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.add, color: AppTheme.whiteColor,),
            ),
          ),
        ),
        onPressed: () {},
        backgroundColor: Colors.transparent,
      ),

      body: Column(
        children: [],
      ),
    );
  }
}
