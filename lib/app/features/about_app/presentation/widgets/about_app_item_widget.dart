import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:flutter/material.dart';

class AboutAppItemWidget extends StatelessWidget {
  const AboutAppItemWidget({
    required this.label,
    this.onPressed,
    super.key,
  });

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: context.textThemeX.medium,
        ),
        const Spacer(),
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            context.l10n.localeName == 'ar'
                ? Icons.keyboard_arrow_left_sharp
                : Icons.keyboard_arrow_right_sharp,
          ),
        )
      ],
    );
  }
}
