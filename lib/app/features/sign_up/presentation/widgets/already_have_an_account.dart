import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            color: context.colorsX.background,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Text(
            context.l10n.signin,
            style: TextStyle(
              color: context.colorsX.primary,
            ),
          ),
        ),
      ],
    );
  }
}
