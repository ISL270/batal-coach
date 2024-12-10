import 'package:btl/app/core/theming/app_colors_extension.dart';
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
        color: context.colorsX.onBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(74),
        ),
      ),
    );
  }
}
