import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditProfileItemsWidget extends StatelessWidget {
  const EditProfileItemsWidget({
    required this.label,
    required this.hintLabel,
    super.key,
  });

  final String label;
  final String hintLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textBaseline: TextBaseline.ideographic,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: context.textThemeX.medium.copyWith(
              textBaseline: TextBaseline.ideographic,
            ),
          ),
        ),
        const Gap(20),
        Expanded(
          child: TextField(
            style: context.textThemeX.medium.bold,
            decoration: InputDecoration(
              hintText: hintLabel,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
