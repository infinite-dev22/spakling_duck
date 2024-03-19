import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/ui/pages/properties/bloc/property_bloc.dart';
import 'package:smart_rent/ui/pages/properties/widgets/loading_widget.dart';
import 'package:smart_rent/ui/pages/properties/widgets/no_data_widget.dart';
import 'package:smart_rent/ui/pages/properties/widgets/not_found_widget.dart';
import 'package:smart_rent/ui/pages/properties/widgets/success_widget.dart';
import 'package:smart_rent/ui/widgets/smart_error_widget.dart';
import 'package:smart_rent/ui/widgets/smart_widget.dart';

class PropertiesLayout extends StatelessWidget {
  Timer? _timer;

  PropertiesLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyBloc, PropertyState>(
      builder: (context, state) {
        if (state.status.isInitial) {
          context.read<PropertyBloc>().add(LoadPropertiesEvent());
        }
        if (state.status.isLoading) {
          return const LoadingWidget();
        }
        if (state.status.isError) {
          return SmartErrorWidget(
            message: 'Error loading properties',
            onPressed: () {
              context.read<PropertyBloc>().add(LoadPropertiesEvent());
            },
          );
        }
        if (state.status.isSuccess) {
          _timer = Timer.periodic(
            const Duration(seconds: 5),
            (timer) {
              context.read<PropertyBloc>().add(RefreshPropertiesEvent());
            },
          );
          if(_timer != null) {
            if(_timer!.isActive) {
              _timer!.cancel();
            }
          }
          return const SuccessWidget();
        }
        if (state.status.isEmpty) {
          return NoDataWidget(
            message: "No properties",
            onPressed: () {
              context.read<PropertyBloc>().add(LoadPropertiesEvent());
            },
          );
        }
        if (state.status.isNotFound) {
          return const NotFoundWidget();
        }
        return const SmartWidget();
      },
      listener: (context, state) {},
    );
  }
}
