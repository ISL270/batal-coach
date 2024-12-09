import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:flutter/material.dart';

class SettingsSectionWidget extends StatelessWidget {
  const SettingsSectionWidget({
    required this.label,
    this.onPressed,
    super.key,
  });

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Text(
            label,
            style: context.textThemeX.medium.copyWith(
              textBaseline: TextBaseline.ideographic,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
          )
        ],
      ),
    );
  }
}
