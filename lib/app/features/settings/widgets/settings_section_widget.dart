import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class SettingsSectionWidget extends StatelessWidget {
  const SettingsSectionWidget({
    required this.label,
    required this.iconData,
    this.onPressed,
    super.key,
  });

  final String label;
  final void Function()? onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          const Gap(5),
          Icon(iconData),
          const Gap(20),
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
