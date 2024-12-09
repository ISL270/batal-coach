import 'package:btl/app/core/constants/app_colors.dart';
import 'package:btl/app/core/extensions/bloc_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/features/settings/settings/settings_bloc.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  const AlreadyHaveAnAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.l10n.alreadyhaveaccount,
          style: TextStyle(
            color: context.settingsBloc.state.isThemeDark ? AppColors.dark : AppColors.lightTint,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          context.l10n.signin,
          style: const TextStyle(
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
