import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:masjid_community_29_06_25/utils/resources/colors_res.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isNumberWithCode;
  final bool obscureText;
  final void Function()? onSuffixTap;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final Widget? leading;
  final EdgeInsetsGeometry? contentPadding;
  final Color fillColor;
  final InputBorder? border;

  final Color borderColor;
  final double borderRadius;
  final double fontSize;
  final void Function(String)? onChanged;
  final ValueChanged<PhoneNumber>? onNumberChanged;
  final String? Function(String?)? validator;
  final bool enabled;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isNumberWithCode = false,
    this.obscureText = false,
    this.onSuffixTap,
    this.prefixIcon,
    this.border,
    this.suffixIcon,
    this.leading,
    this.contentPadding,
    this.fillColor = ColorRes.bgColor,
    this.borderColor = Colors.grey,
    this.borderRadius = 12,
    this.fontSize = 16,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.onNumberChanged,
    this.prefixWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (isNumberWithCode) {
      return IntlPhoneField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: ColorRes.hintTextColor),
          filled: true,
          fillColor: fillColor,
          contentPadding: contentPadding ?? const EdgeInsets.all(12),
          border: border ?? UnderlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        initialCountryCode: 'IN',
        onChanged: onNumberChanged,
        enabled: enabled,
        keyboardType: TextInputType.number,
      );
    }


    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword ? obscureText : false,
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      style: TextStyle(fontSize: fontSize),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(color: ColorRes.hintTextColor),
        filled: true,
        fillColor: fillColor,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        border: border ?? UnderlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: prefixWidget ?? ((prefixIcon == null) ? null : Icon(prefixIcon, color: ColorRes.hintTextColor,)),
        suffixIcon: isPassword ? IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off, color: ColorRes.hintTextColor,),
          onPressed: onSuffixTap,
        )
            : suffixIcon,
      ),
    );
  }
}
