import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientGoalsScreen extends StatelessWidget {
  const ClientGoalsScreen({super.key});

  static const name = 'client-goals';

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.l10n.editGoal, style: context.textThemeX.large),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              context.l10n.done,
              style: context.textThemeX.medium,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 30.h),
          Text(
            context.l10n.goalDes,
            style: context.textThemeX.medium
                .copyWith(color: context.colorsX.secondaryBackground),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: Center(
              child: Button.filled(
                onPressed: () {},
                label: '📇 ${context.l10n.addCountDown}',
              ),
            ),
          )
        ],
      ),
    );
  }
}
