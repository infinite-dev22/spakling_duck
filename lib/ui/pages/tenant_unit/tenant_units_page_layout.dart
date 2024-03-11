import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/ui/pages/currency/bloc/currency_bloc.dart';
import 'package:smart_rent/ui/pages/period/bloc/period_bloc.dart';
import 'package:smart_rent/ui/pages/tenant_unit/forms/tenant_unit_form.dart';
import 'package:smart_rent/ui/pages/tenants/bloc/tenant_bloc.dart';
import 'package:smart_rent/ui/pages/units/bloc/unit_bloc.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';

class TenantUnitsPageLayout extends StatelessWidget {
  final Property property;

  const TenantUnitsPageLayout({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "add_unit",
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
        onPressed: () => showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return MultiBlocListener(
                listeners: [
                  BlocProvider(create: (context) => TenantBloc()),
                  BlocProvider(create: (context) => UnitBloc()),
                  BlocProvider(create: (context) => PeriodBloc()),
                  BlocProvider(create: (context) => CurrencyBloc()),
                ],
                child: TenantUnitForm(
                  addButtonText: 'Add Tenant',
                  isUpdate: false,
                  property: property,
                ),
              );
            }),
        backgroundColor: AppTheme.primary,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column();
  }
}
