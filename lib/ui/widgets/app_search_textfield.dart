import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';

class AppSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool isEmail;
  final BorderSide borderSide;
  final Color fillColor;
  final TextStyle? style;
  final bool enabled;
  final String? title;
  final VoidCallback function;
  final ValueChanged<String>? onCahnged;

  const AppSearchTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.isEmail = false,
    this.borderSide = BorderSide.none,
    this.fillColor = AppTheme.fillColor,
    this.style,
    this.enabled = true,
    this.title,
    required this.function,
    this.onCahnged
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: TextFormField(
            onChanged: onCahnged,
            validator: (val) =>
                val!.isEmpty ? 'Required field, Please fill in.' : null,
            controller: controller,
            obscureText: obscureText,
            style: style,
            autofocus: false,
            enabled: enabled,
            decoration: InputDecoration(
              focusedBorder: (borderSide != BorderSide.none)
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    )
                  : null,
              enabledBorder: (borderSide != BorderSide.none)
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    )
                  : null,
              border: OutlineInputBorder(
                borderSide: borderSide,
                borderRadius: BorderRadius.circular(20),
              ),
              // fillColor: fillColor,
              fillColor: fillColor,
              filled: true,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              suffixIcon: const Icon(Icons.filter_alt_outlined),
              prefixIcon: const Icon(Icons.search),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      ],
    );
  }
}
