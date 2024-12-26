import 'package:btl/app/core/assets_gen/assets.gen.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ClientLimitationsScreen extends StatelessWidget {
  const ClientLimitationsScreen({super.key});

  static const name = 'clientLimitationsScreen';

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.l10n.limitationsInjuries,
          style: context.textThemeX.large,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              context.l10n.add,
              style: context.textThemeX.medium,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.icons.notes,
            width: 300.w,
          ),
          Text(
            context.l10n.noNotes,
            style: context.textThemeX.heading.bold,
          ),
          Gap(20.h),
          Center(
            child: SizedBox(
              width: 0.32.sh,
              child: Text(
                context.l10n.notesDes,
                style: context.textThemeX.small,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Gap(20.h),
          Button.filled(onPressed: () {}, label: context.l10n.addNotes)
        ],
      ),
    );
  }
}
