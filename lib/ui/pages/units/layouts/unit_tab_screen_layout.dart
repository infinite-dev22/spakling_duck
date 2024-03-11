import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/ui/pages/floors/bloc/floor_bloc.dart';
import 'package:smart_rent/ui/pages/properties/widgets/loading_widget.dart';
import 'package:smart_rent/ui/pages/properties/widgets/no_data_widget.dart';
import 'package:smart_rent/ui/pages/properties/widgets/not_found_widget.dart';
import 'package:smart_rent/ui/pages/property_details/forms/floor/add_property_floor_form.dart';
import 'package:smart_rent/ui/pages/units/bloc/unit_bloc.dart';
import 'package:smart_rent/ui/pages/units/forms/add_unit_form.dart';
import 'package:smart_rent/ui/pages/units/widgets/unit_card_widget.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/app_search_textfield.dart';
import 'package:smart_rent/ui/widgets/smart_error_widget.dart';
import 'package:smart_rent/ui/widgets/smart_widget.dart';
import 'package:smart_rent/utilities/extra.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UnitsTabScreenLayout extends StatelessWidget {
  final Property property;

  const UnitsTabScreenLayout({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return BlocConsumer<UnitBloc, UnitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.status == UnitStatus.initial) {
          context.read<UnitBloc>().add(LoadAllUnitsEvent(property.id!));
        }
        if (state.status == UnitStatus.loading) {
          return const LoadingWidget();
        }
        if (state.status == UnitStatus.accessDenied) {
          return const NotFoundWidget();
        }
        if (state.status == UnitStatus.empty) {
          return Scaffold(
            backgroundColor: AppTheme.appBgColor,
            appBar: _buildAppTitle(),
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
            body: const NoDataWidget(),
          );
        }
        if (state.status == UnitStatus.error) {
          return const SmartErrorWidget();
        }
        if (state.status == UnitStatus.success) {
          return Scaffold(
            backgroundColor: AppTheme.appBgColor,
            appBar: _buildAppTitle(),
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
            body: ListView.builder(
              controller: unitsScrollController,
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (context, index) => UnitCardWidget(
                  unitModel: state.units![index],
                  index: index),
              itemCount: state.units!.length,
            ),
          );
        }
        return const SmartWidget();
      },
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
