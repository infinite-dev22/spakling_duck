import 'package:flutter/material.dart';
import 'package:smart_rent/ui/pages/propert_details/forms/floor/add_property_floor_form.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';

class FloorsSuccessScreen extends StatelessWidget {
  const FloorsSuccessScreen({super.key});

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
                  );
                });
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.house),
                  SizedBox(
                    width: 3,
                  ),
                  Text('Add Floor', style: AppTheme.subTextBold2)
                ],
              ),
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
