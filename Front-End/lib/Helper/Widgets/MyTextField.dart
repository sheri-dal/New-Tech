import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final bool obscuretext;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final InputBorder? border;
  final bool? enable;
  const MyTextField(
      {Key? key,
      this.labelText,
      this.obscuretext = false,
      this.controller,
      this.suffixIcon,
      this.focusNode,
      this.textInputType,
      this.textInputAction,
      this.maxLines = 1,
      this.hintText,
      this.border,
      this.enable,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      obscureText: obscuretext,
      focusNode: focusNode,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      enabled: enable,
      decoration: InputDecoration(
          border: border,
          suffixIcon: suffixIcon,
          hintText: hintText,
          // border: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          labelText: labelText),
    );
  }
}
