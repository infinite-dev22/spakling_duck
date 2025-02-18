import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/ui/pages/floors/bloc/floor_bloc.dart';
import 'package:smart_rent/ui/pages/floors/bloc/form/floor_form_bloc.dart';
import 'package:smart_rent/ui/pages/properties/widgets/loading_widget.dart';
import 'package:smart_rent/ui/pages/properties/widgets/no_data_widget.dart';
import 'package:smart_rent/ui/pages/properties/widgets/not_found_widget.dart';
import 'package:smart_rent/ui/pages/property_details/forms/floor/add_property_floor_form.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/app_search_textfield.dart';
import 'package:smart_rent/ui/widgets/smart_error_widget.dart';
import 'package:smart_rent/ui/widgets/smart_widget.dart';
import 'package:smart_rent/utilities/extra.dart';

class FloorsSuccessWidget extends StatelessWidget {
  final Property property;

  const FloorsSuccessWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FloorBloc, FloorState>(
      listener: (context, state) => log('RECEIVED STATUS: ${state.status}'),
      builder: (context, state) {
        if (state.status.isInitial) {
          context.read<FloorBloc>().add(LoadAllFloorsEvent(property.id!));
        }
        if (state.status.isLoading) {
          return const LoadingWidget();
        }
        if (state.status.isNotFound) {
          return const NotFoundWidget();
        }
        if (state.status.isEmpty) {
          return _buildEmptyBody(context, state);
        }
        if (state.status.isError) {
          return SmartErrorWidget(
            message: 'Error loading floors',
            onPressed: () {
              context.read<FloorBloc>().add(LoadAllFloorsEvent(property.id!));
            },
          );
        }
        if (state.status.isSuccess) {
          return _buildSuccessBody(context, state);
        }
        return const SmartWidget();
      },
    );
  }

  Widget _buildSuccessBody(BuildContext parentContext, FloorState state) {
    return Scaffold(
      backgroundColor: AppTheme.appBgColor,
      appBar: _buildAppTitle(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "add_floor",
        label: const Text(
          'Add',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
        onPressed: () => showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
            context: parentContext,
            builder: (context) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => FloorFormBloc()),
                ],
                child: AddPropertyFloorForm(
                  parentContext: parentContext,
                  addButtonText: 'Add',
                  isUpdate: false,
                  property: property,
                ),
              );
            }),
        backgroundColor: AppTheme.primary,
      ),
      body: ListView.builder(
        controller: floorsScrollController,
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          // width: width,
          // height: height,
          decoration: BoxDecoration(
            color: AppTheme.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppTheme.shadowColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: .1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(
            title: Text(state.floors![index].name!),
          ),
        ),
        itemCount: state.floors!.length,
      ),
    );
  }

  Widget _buildEmptyBody(BuildContext parentContext, FloorState state) {
    return Scaffold(
      backgroundColor: AppTheme.appBgColor,
      appBar: _buildAppTitle(),
      floatingActionButton: FloatingActionButton(
        heroTag: "add_floor",
        onPressed: () => showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
            context: parentContext,
            builder: (context) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => FloorFormBloc()),
                ],
                child: AddPropertyFloorForm(
                  parentContext: parentContext,
                  addButtonText: 'Add',
                  isUpdate: false,
                  property: property,
                ),
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
        message: "No floors",
        onPressed: () {
          parentContext.read<FloorBloc>().add(LoadAllFloorsEvent(property.id!));
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
          hintText: 'Search floors',
          obscureText: false,
          function: () {},
          fillColor: AppTheme.textBoxColor,
        ),
      ),
    );
  }
}
