import 'package:flutter/material.dart';
import 'package:smart_rent/ui/themes/app_theme.dart';


class TextFieldLabelWidget extends StatelessWidget {
  final String label;
  final bool showIcon;
  const TextFieldLabelWidget({super.key, required this.label,  this.showIcon = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label, style: AppTheme.appTitle7,),
        SizedBox(width: 5,),
        showIcon ? Icon(Icons.emergency_rounded, color: AppTheme.red, size: 10,) : Container()
      ],
    );
  }
}
