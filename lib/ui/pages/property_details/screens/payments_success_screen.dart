
import 'package:SmartCase/data_layer/models/property/property_response_model.dart';
import 'package:SmartCase/ui/pages/payments/forms/add_payment_form.dart';
import 'package:SmartCase/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';

class PaymentsSuccessScreen extends StatelessWidget {
  final Property property;
  const PaymentsSuccessScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "add_payment",
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        onPressed: () => showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return AddPaymentForm(
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
