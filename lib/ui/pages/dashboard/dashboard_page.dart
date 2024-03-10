import 'package:SmartCase/ui/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:SmartCase/ui/pages/dashboard/widgets/dashboard_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return const DashboardLayout();
      },
      listener: (context, state) {},
    );
  }
}
