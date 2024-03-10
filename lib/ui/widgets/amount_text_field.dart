import 'package:SmartCase/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? suffix;
  final bool obscureText;
  final bool isEmail;
  final BorderSide borderSide;
  final Color fillColor;
  final TextStyle? style;
  final bool enabled;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextInputType? keyBoardType;
  final List<TextInputFormatter>? inputFormatters;

  const AmountTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.obscureText,
    this.isEmail = false,
    this.borderSide = BorderSide.none,
    this.fillColor = AppTheme.textBoxColor,
    this.style,
    this.enabled = true,
    this.onChanged,
    this.onTap,
    this.keyBoardType,
    this.suffix,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        inputFormatters: inputFormatters ??
            [
              LengthLimitingTextInputFormatter(35),
            ],
        cursorColor: AppTheme.gray45,
        validator: (val) =>
        val!.isEmpty ? 'Required field, Please fill in.' : null,
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        style: style,
        enabled: enabled,
        decoration: InputDecoration(
          focusedBorder: (borderSide != BorderSide.none)
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppTheme.gray45,
              width: 2.0,
            ),
          )
              : null,
          enabledBorder: (borderSide != BorderSide.none)
              ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppTheme.gray45,
            ),
          )
              : null,
          border: OutlineInputBorder(
            borderSide: borderSide,
            borderRadius: BorderRadius.circular(10),
          ),
          // fillColor: fillColor,
          fillColor: AppTheme.itemBgColor,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppTheme.inActiveColor,
            fontSize: 16,
          ),
          suffix: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: Text(suffix.toString()),
              )),
        ),
        keyboardType: keyBoardType ?? TextInputType.emailAddress,
        onTap: onTap,
      ),
    );
  }
}