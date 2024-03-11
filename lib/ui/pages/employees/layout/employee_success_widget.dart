import 'package:smart_rent/ui/pages/employees/layout/employee_item_widget.dart';
import 'package:smart_rent/ui/pages/root/bloc/nav_bar_bloc.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/appbar_content.dart';
import 'package:smart_rent/utilities/extra.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EmployeeSuccessWidget extends StatelessWidget {
  const EmployeeSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    usersScrollController.addListener(() {
      if (usersScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (context.read<NavBarBloc>().state.isVisible != false) {
          context.read<NavBarBloc>().add(ChangeNavBarVisibility(
              false, context.read<NavBarBloc>().state.idSelected));
        }
      } else {
        if (context.read<NavBarBloc>().state.isVisible != true) {
          context.read<NavBarBloc>().add(ChangeNavBarVisibility(
              true, context.read<NavBarBloc>().state.idSelected));
        }
      }
    });

    return _buildBody();
  }

  Widget _buildBody() {
    return Scaffold(
      appBar: AppBar(
        title: const TitleBarImageHolder(),
        backgroundColor: AppTheme.primaryColor,
        centerTitle: true,
      ),
      body: ListView.builder(
          controller: usersScrollController,
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) {
            return const EmployeeItemWidget();
          }),
    );
  }
}
