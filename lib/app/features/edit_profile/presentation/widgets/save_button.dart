import 'package:btl/app/core/extensions/english_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 175,
      height: 55,
      child: Button.filled(
        label: context.l10n.save.capitalized,
        onPressed: () {
          context.pop();
        },
      ),
    );
  }
}
