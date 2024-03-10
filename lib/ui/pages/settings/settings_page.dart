import 'package:SmartCase/ui/themes/app_theme.dart';
import 'package:SmartCase/ui/widgets/appbar_content.dart';
import 'package:flutter/material.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: const TitleBarImageHolder(),
        centerTitle: true,
        foregroundColor: AppTheme.whiteColor,
      ),
    );
  }
}
