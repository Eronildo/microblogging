import 'package:flutter/material.dart';
import 'package:microblogging/src/shared/utils/custom_callbacks.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final bool autofocus;
  final bool obscureText;
  final String labelText;
  final String hintText;
  final String helperText;
  final ValueCallback onSaved;
  final ValueCallback onChanged;
  final ValueCallback onFieldSubmitted;
  final ValidatorCallback validator;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final FocusNode focusNode;
  final TextEditingController controller;

  const CustomTextFormField(
      {Key key,
      this.keyboardType = TextInputType.text,
      this.autofocus = false,
      this.obscureText = false,
      this.labelText,
      this.hintText,
      this.helperText,
      this.onSaved,
      this.onChanged,
      this.onFieldSubmitted,
      this.validator,
      this.prefixIcon,
      this.suffixIcon,
      this.focusNode,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autofocus: autofocus,
      obscureText: obscureText,
      style: TextStyle(letterSpacing: 2.0,),
      decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          helperText: helperText),
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      focusNode: focusNode,
      onChanged: onChanged,
    );
  }
}
