import 'package:btl/app/coach/features/exercises/presentation/exercises_screen.dart';
import 'package:btl/app/core/constants/app_colors.dart';
import 'package:btl/app/core/extensions/bloc_x.dart';
import 'package:btl/app/core/extensions/english_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/features/settings/settings/settings_bloc.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.labelText,
    required this.textEditingController,
    required this.focusNode,
    required this.validator,
    required this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final String labelText;
  final String? Function(String?)? validator;
  final void Function(String?)? onFieldSubmitted;
  final void Function(String?)? onChanged;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      style: TextStyle(
        color: context.settingsBloc.state.isThemeDark ? AppColors.onLight : AppColors.onDark,
      ),
      decoration: InputDecoration(
        label: Text(
          labelText.capitalized,
          style: TextStyle(
            fontSize: 16,
            color: context.settingsBloc.state.isThemeDark ? AppColors.onLight : AppColors.onDark,
          ),
        ),
        floatingLabelStyle: TextStyle(
          color: context.settingsBloc.state.isThemeDark ? AppColors.onLight : AppColors.onDark,
        ),
        labelStyle: TextStyle(
          color: context.settingsBloc.state.isThemeDark ? AppColors.onLight : AppColors.onDark,
        ),
        hintStyle: TextStyle(
          color: context.settingsBloc.state.isThemeDark ? AppColors.onLight : AppColors.onDark,
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
        color: context.settingsBloc.state.isThemeDark ? AppColors.onLight : AppColors.onDark,
      ),
    );
  }
}
