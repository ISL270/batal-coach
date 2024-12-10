import 'package:btl/app/core/extension_methods/english_x.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/features/about_app/presentation/widgets/about_app_item_widget.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
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
            context.l10n.localeName == 'ar'
                ? Icons.keyboard_arrow_right_sharp
                : Icons.keyboard_arrow_left_sharp,
            size: 28,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        centerTitle: true,
        title: Text(
          context.l10n.aboutapp.capitalized,
          style: context.textThemeX.medium.bold.copyWith(
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          const Gap(25),
          Row(
            children: [
              Text(
                context.l10n.version.capitalized,
                style: context.textThemeX.medium,
              ),
              const Spacer(),
              Text(
                '0.0.1',
                style: context.textThemeX.medium.bold,
              ),
            ],
          ),
          const Gap(30),
          AboutAppItemWidget(
            label: context.l10n.privacypolicy.capitalized,
          ),
          const Gap(30),
          AboutAppItemWidget(
            label: context.l10n.termsofservice.capitalized,
          ),
        ],
      ),
    );
  }
}
