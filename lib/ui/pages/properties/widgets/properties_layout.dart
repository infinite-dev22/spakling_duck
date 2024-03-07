import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_rent/ui/pages/properties/bloc/property_bloc.dart';
import 'package:smart_rent/ui/pages/properties/widgets/properties_barrel.dart';
import 'package:smart_rent/ui/widgets/smart_error_widget.dart';
import 'package:smart_rent/ui/widgets/smart_widget.dart';

class PropertiesLayout extends StatelessWidget {
  const PropertiesLayout({super.key});

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
          return const SmartErrorWidget();
        }
        if (state.status.isSuccess) {
          return SuccessWidget();
        }
        if (state.status.isEmpty) {
          return const NoDataWidget();
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
