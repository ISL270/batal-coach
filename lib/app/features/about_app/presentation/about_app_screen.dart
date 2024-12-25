import 'package:btl/app/core/extension_methods/bloc_x.dart';
import 'package:btl/app/core/extension_methods/english_x.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/l10n/language.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/features/settings/settings/settings_bloc.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  static const name = 'aboutapp';

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            context.settingsBloc.state.language.isArabic
                ? Icons.keyboard_arrow_right_sharp
                : Icons.keyboard_arrow_left_sharp,
            size: 28.w,
          ),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          context.l10n.aboutapp.capitalized,
          style: context.textThemeX.medium.bold.copyWith(fontSize: 20.sp),
        ),
      ),
      body: Column(
        children: [
          Gap(25.h),
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
          Gap(30.h),
          _AboutAppItemWidget(label: context.l10n.privacypolicy.capitalized),
          Gap(30.h),
          _AboutAppItemWidget(label: context.l10n.termsofservice.capitalized),
        ],
      ),
    );
  }
}

class _AboutAppItemWidget extends StatelessWidget {
  const _AboutAppItemWidget({
    required this.label,
    // ignore: unused_element
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
            context.settingsBloc.state.isArabic
                ? Icons.keyboard_arrow_left_sharp
                : Icons.keyboard_arrow_right_sharp,
          ),
        ),
      ],
    );
  }
}
