import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/ui/pages/payments/bloc/form/payment_form_bloc.dart';
import 'package:smart_rent/ui/pages/payments/forms/add_payment_form.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';

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
        onPressed: () =>
            showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return BlocProvider(
                    create: (context) => PaymentFormBloc(),
                    child: AddPaymentForm(
                      parentContext: context,
                      addButtonText: 'Add',
                      isUpdate: false,
                      property: property,
                    ),
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
