import 'package:smart_rent/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final bool isEmail;
  final BorderSide borderSide;
  final Color fillColor;
  final TextStyle? style;
  final bool enabled;
  final Function(String)? onChanged;
  final Function()? onTap;
  final List<String>? autofillHints;
  final TextInputType? keyBoardType;
  final List<TextInputFormatter>? inputFormatters;

  const AuthTextField({
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
    this.autofillHints,
    this.keyBoardType,
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
        autofillHints: autofillHints,
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
          fillColor: fillColor,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppTheme.inActiveColor,
            fontSize: 16,
          ),
        ),
        keyboardType: keyBoardType ?? TextInputType.emailAddress,
        onTap: onTap,
      ),
    );
  }
}

class AuthPasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final BorderSide borderSide;
  final Color fillColor;
  final Color iconColor;
  final bool enabled;
  final TextStyle? style;
  final Function()? onTap;
  final List<String>? autofillHints;

  const AuthPasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.borderSide = BorderSide.none,
    this.fillColor = AppTheme.textBoxColor,
    this.iconColor = AppTheme.darker,
    this.style,
    this.enabled = true,
    this.onTap,
    this.autofillHints,
  });

  @override
  State<AuthPasswordTextField> createState() => _AuthPasswordTextField();
}

class _AuthPasswordTextField extends State<AuthPasswordTextField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        autofillHints: widget.autofillHints,
        cursorColor: AppTheme.gray45,
        validator: (val) =>
            val!.isEmpty ? 'Required field, Please fill in.' : null,
        controller: widget.controller,
        obscureText: obscure,
        style: widget.style,
        enabled: widget.enabled,
        decoration: InputDecoration(
          focusedBorder: (widget.borderSide != BorderSide.none)
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppTheme.gray45,
                    width: 2.0,
                  ),
                )
              : null,
          enabledBorder: (widget.borderSide != BorderSide.none)
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: AppTheme.gray45,
                  ),
                )
              : null,
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscure = !obscure;
                });
              },
              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility_rounded,
                color: widget.iconColor,
              )),
          border: OutlineInputBorder(
            borderSide: widget.borderSide,
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: widget.fillColor,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: AppTheme.inActiveColor,
            fontSize: 16,
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
        onTap: widget.onTap,
      ),
    );
  }
}
