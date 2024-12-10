import 'package:btl/app/core/extension_methods/english_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:flutter/material.dart';

class AvatarLabelRow extends StatelessWidget {
  const AvatarLabelRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textBaseline: TextBaseline.ideographic,
      children: [
        const CircleAvatar(radius: 18),
        const SizedBox(
          width: 15,
        ),
        Text(
          context.l10n.profile.capitalized,
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
    );
  }
}
