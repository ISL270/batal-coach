import 'package:btl/app/core/extension_methods/english_x.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.labelText,
    required this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.isPasswordField = false,
    this.inputFormatter,
    super.key,
  });

  final String labelText;

  final void Function(String?)? onFieldSubmitted;
  final void Function(String) onChanged;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final bool isPasswordField;
  final List<TextInputFormatter>? inputFormatter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      obscureText: isPasswordField,
      onChanged: onChanged,
      inputFormatters: const [],
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      style: TextStyle(
        color: context.colorsX.background,
      ),
      decoration: InputDecoration(
        label: Text(
          labelText.capitalized,
          style: TextStyle(
            fontSize: 16,
            color: context.colorsX.background,
          ),
        ),
        floatingLabelStyle: TextStyle(
          color: context.colorsX.background,
        ),
        labelStyle: TextStyle(
          color: context.colorsX.background,
        ),
        hintStyle: TextStyle(
          color: context.colorsX.background,
        ),
        border: customBorder(context),
        disabledBorder: customBorder(context),
        enabledBorder: customBorder(context),
        focusedBorder: customBorder(context),
      ),
    );
  }

  OutlineInputBorder customBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: context.colorsX.background,
      ),
    );
  }
}
