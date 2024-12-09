import 'package:btl/app/core/constants/app_colors.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CustomIconElevatedButton extends StatelessWidget {
  const CustomIconElevatedButton({
    required this.text,
    this.onPressed,
    this.infoFilled = false,
    super.key,
  });

  final String text;
  final void Function()? onPressed;
  final bool infoFilled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        style: TextButton.styleFrom(
          backgroundColor: infoFilled ? AppColors.primary : AppColors.disabledButton,
        ),
        label: Center(
          child: Text(
            '       $text',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        icon: const Icon(
          Icons.navigate_next_sharp,
          color: AppColors.onDark,
        ),
        iconAlignment: IconAlignment.end,
        onPressed: onPressed,
      ),
    );
  }
}
