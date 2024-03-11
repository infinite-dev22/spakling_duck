import 'package:smart_rent/ui/pages/auth_pages/login_page/widgets/action_text_widget.dart';
import 'package:smart_rent/ui/pages/auth_pages/login_page/widgets/clickable_text_widget.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';


class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Column(
      children: [
        const ClickableTextWidget(
            data: 'contact us: ', link: 'info@infosectechno.com'),
        const SizedBox(height: 8),
        const ActionTextWidget(data: '+256 (0)779416755'),
        const SizedBox(height: 8),
        Text(
          'copyright @ ${DateTime.now().year} smart_rent Manager',
          style: const TextStyle(
            color: AppTheme.inActiveColor,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
