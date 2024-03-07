import 'package:flutter/material.dart';
import 'package:smart_rent/ui/pages/employees/layout/employee_item_widget.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:smart_rent/ui/widgets/appbar_content.dart';

class EmployeeSuccessWidget extends StatelessWidget {
  const EmployeeSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) {
            return const EmployeeItemWidget();
          }),
    );
  }
}
