import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final ValueChanged<String> onChange;
  final String? errorText;
  final TextInputType keyboardType;
  final String? initValue;

  const CustomTextFormFiled({
    Key? key,
    required this.onChange,
    this.keyboardType = TextInputType.text,
    this.obscureText,
    this.suffixIcon,
    this.errorText,
    this.label,
    this.prefixIcon,
    this.initValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      initialValue: initValue,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      onChanged: onChange,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          errorText: errorText,
          border: _textFiledBorder(context),
          errorBorder: _textFiledBorder(context),
          focusedBorder: _textFiledBorder(context),
          focusedErrorBorder: _textFiledBorder(context)),
    );
  }

  OutlineInputBorder _textFiledBorder(
          BuildContext context) =>
      OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1),
          borderRadius: BorderRadius.circular(10));
}
