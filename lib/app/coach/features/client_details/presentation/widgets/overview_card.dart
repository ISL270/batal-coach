import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({required this.title, required this.subTitle, required this.image, super.key, this.onTap});

  final String title;
  final String subTitle;
  final String image;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: context.colorsX.isDark
                ? context.colorsX.background
                : context.colorsX.secondaryBackground,
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                image,
                width: 40.w,
                colorFilter: ColorFilter.mode(
                  context.colorsX.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            title: Text(
              title,
              style: context.textThemeX.large.bold.copyWith(fontSize: 20),
            ),
            subtitle: Text(
              subTitle,
              style: context.textThemeX.small,
            ),
          ),
        ),
      ),
    );
  }
}
