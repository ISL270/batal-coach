import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xffDD908C),
            radius: 45.sp,
            child: Text(
              'AH',
              style: context.textThemeX.large.copyWith(
                color: context.colorsX.secondaryBackground,
                fontSize: 24.sp,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff7469DA),
              ),
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 19,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
