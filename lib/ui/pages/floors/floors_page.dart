import 'package:smart_rent/data_layer/models/property/property_response_model.dart';
import 'package:smart_rent/ui/pages/floors/bloc/floor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/floors_success_widget.dart';


class FloorsPage extends StatelessWidget {
  final Property property;
  const FloorsPage({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FloorBloc(),
      child: FloorsSuccessWidget(property: property),
    );
  }
}
