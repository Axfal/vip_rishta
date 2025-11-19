import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show TextInputFormatter;
import 'package:rishta_app/core/constants/color/app_color.dart';
import 'package:rishta_app/core/constants/text/app_text.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
 final Color borderColor;
  final bool isDropdown;
  final VoidCallback? onTap;
  final void Function(String)? onChange;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.enabled = true,
    this.prefixText,
    this.borderColor = Colors.white,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.obscureText = false,
    this.inputFormatters,
    this.isDropdown = false,
    this.onTap,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: borderColor),
      obscureText: obscureText,
      enabled: enabled,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      cursorColor: borderColor,
      readOnly: isDropdown,
      onTap: isDropdown ? onTap : null,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: AppText.caption.copyWith(color: borderColor),
        hintText: hintText,
        hintStyle: AppText.caption.copyWith(color: borderColor),
        prefixText: prefixText,
        prefixIcon: prefixIcon,
        suffixIcon: isDropdown
            ? Icon(Icons.keyboard_arrow_down, color: borderColor)
            : suffixIcon,
        errorStyle: TextStyle(color: borderColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
      ),
    );
  }
}
