import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MetricsWidget extends StatelessWidget {
  const MetricsWidget(
      {required this.title,
      required this.subTitle,
      required this.image,
      super.key});

  final String title;
  final String subTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 180.h,
        width: 200.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.colorsX.isDark
              ? context.colorsX.background
              : context.colorsX.secondaryBackground,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: context.textThemeX.medium.bold.copyWith(
                color: context.colorsX.primary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                subTitle,
                style: context.textThemeX.small.copyWith(color: Colors.grey),
              ),
            ),
            SvgPicture.asset(
              image,
              width: 40.w,
              colorFilter: ColorFilter.mode(
                context.colorsX.primary,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
