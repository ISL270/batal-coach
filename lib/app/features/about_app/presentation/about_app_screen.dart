import 'package:batal/core/extension_methods/english_x.dart';
import 'package:batal/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/extension_methods/bloc_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/features/settings/domain/settings.dart';
import 'package:btl/app/features/settings/settings/settings_bloc.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  static const name = 'about-app';

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.l10n.aboutapp.capitalized,
          style: context.textThemeX.medium.bold.copyWith(fontSize: 20.sp),
        ),
      ),
      body: Column(
        spacing: 30.h,
        children: [
          Row(
            children: [
              Text(
                context.l10n.version.capitalized,
                style: context.textThemeX.medium,
              ),
              const Spacer(),
              Text('0.0.1', style: context.textThemeX.medium.bold),
            ],
          ),
          _AboutAppItemWidget(label: context.l10n.privacyPolicy.capitalized, onPressed: () {}),
          _AboutAppItemWidget(label: context.l10n.termsOfService.capitalized, onPressed: () {}),
        ],
      ),
    );
  }
}

class _AboutAppItemWidget extends StatelessWidget {
  const _AboutAppItemWidget({
    required this.label,
    this.onPressed,
  });

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: context.textThemeX.medium),
        const Spacer(),
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            context.settingsBloc.state.settings.isArabic
                ? Icons.keyboard_arrow_left_sharp
                : Icons.keyboard_arrow_right_sharp,
          ),
        ),
      ],
    );
  }
}
