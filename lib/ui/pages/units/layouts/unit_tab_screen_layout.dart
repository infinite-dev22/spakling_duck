import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/ui/pages/properties/widgets/loading_widget.dart';
import 'package:smart_rent/ui/pages/properties/widgets/no_data_widget.dart';
import 'package:smart_rent/ui/pages/properties/widgets/not_found_widget.dart';
import 'package:smart_rent/ui/pages/units/bloc/unit_bloc.dart';
import 'package:smart_rent/ui/pages/units/forms/add_unit_form.dart';
import 'package:smart_rent/ui/pages/units/widgets/unit_card_widget.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/app_search_textfield.dart';
import 'package:smart_rent/ui/widgets/smart_error_widget.dart';
import 'package:smart_rent/ui/widgets/smart_widget.dart';
import 'package:smart_rent/utilities/extra.dart';

class UnitsTabScreenLayout extends StatelessWidget {
  final Property property;

  const UnitsTabScreenLayout({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return BlocProvider(
      create: (context) => UnitBloc(),
      child: BlocBuilder<UnitBloc, UnitState>(
        builder: (context, state) {
          print("STATUS: ${state.status}");
          if (state.status.isInitial) {
            context.read<UnitBloc>().add(LoadAllUnitsEvent(property.id!));
          }
          if (state.status.isLoading) {
            return const LoadingWidget();
          }
          if (state.status.isAccessDenied) {
            return const NotFoundWidget();
          }
          if (state.status.isEmpty) {
            return Scaffold(
              backgroundColor: AppTheme.appBgColor,
              appBar: _buildAppTitle(),
              floatingActionButton: FloatingActionButton(
                heroTag: "add_unit",
                onPressed: () => showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return AddUnitForm(
                        addButtonText: 'Add Tenant',
                        isUpdate: false,
                        property: property,
                      );
                    }),
                backgroundColor: AppTheme.primary,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              body: NoDataWidget(
                message: "No tenant units",
                onPressed: () {
                  context.read<UnitBloc>().add(LoadAllUnitsEvent(property.id!));
                },
              ),
            );
          }
          if (state.status.isError) {
            return SmartErrorWidget(
              message: 'Error loading units',
              onPressed: () {
                context.read<UnitBloc>().add(LoadAllUnitsEvent(property.id!));
              },
            );
          }
          if (state.status.isReloaded) {
            Timer.run(() async {
              context.read<UnitBloc>().add(RefreshUnitsEvent(property.id!));
            });
            return Scaffold(
              backgroundColor: AppTheme.appBgColor,
              appBar: _buildAppTitle(),
              floatingActionButton: FloatingActionButton(
                heroTag: "add_unit",
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
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              body: ListView.builder(
                controller: unitsScrollController,
                padding: const EdgeInsets.only(top: 10),
                itemBuilder: (context, index) =>
                    UnitCardWidget(unitModel: state.units[index], index: index),
                itemCount: state.units.length,
              ),
            );
          }
          if (state.status.isSuccess) {
            Timer.run(() async {
              context.read<UnitBloc>().add(RefreshUnitsEvent(property.id!));
            });
            return Scaffold(
              backgroundColor: AppTheme.appBgColor,
              appBar: _buildAppTitle(),
              floatingActionButton: FloatingActionButton(
                heroTag: "add_unit",
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
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              body: ListView.builder(
                controller: unitsScrollController,
                padding: const EdgeInsets.only(top: 10),
                itemBuilder: (context, index) =>
                    UnitCardWidget(unitModel: state.units[index], index: index),
                itemCount: state.units.length,
              ),
            );
          }
          return const SmartWidget();
        },
      ),
    );
  }

  PreferredSize _buildAppTitle() {
    TextEditingController searchController = TextEditingController();
    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: Container(
        padding: const EdgeInsets.only(
          top: 15,
          left: 10,
          right: 10,
          bottom: 15,
        ),
        decoration: const BoxDecoration(color: Colors.transparent),
        child: AppSearchTextField(
          controller: searchController,
          hintText: 'Search units',
          obscureText: false,
          function: () {},
          fillColor: AppTheme.textBoxColor,
        ),
      ),
    );
  }
}
