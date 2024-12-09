import 'package:btl/app/core/constants/app_colors.dart';
import 'package:btl/app/core/extensions/bloc_x.dart';
import 'package:btl/app/features/settings/settings/settings_bloc.dart';
import 'package:flutter/material.dart';

class SignUpContainerShapeWidget extends StatelessWidget {
  const SignUpContainerShapeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.settingsBloc.state.isThemeDark ? AppColors.onDark : AppColors.onLight,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(74),
        ),
      ),
    );
  }
}
