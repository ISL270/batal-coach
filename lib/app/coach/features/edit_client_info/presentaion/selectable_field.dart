import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SelectableField extends StatelessWidget {
  const SelectableField({
    required this.context,
    required this.label,
    required this.value,
    required this.options,
    super.key,
  });

  final BuildContext context;
  final String label;
  final String value;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showBottomSheet(context, label, value, options),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: context.textThemeX.medium),
                Text(value, style: context.textThemeX.medium),
              ],
            ),
            SizedBox(height: 18.h),
            const Divider(height: 0, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String label,
      String selectedValue, List<String> options) {
    showModalBottomSheet<dynamic>(
      backgroundColor: context.colorsX.secondaryBackground,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.sp)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: context.textThemeX.medium),
              Gap(16.h),
              for (final String option in options)
                ListTile(
                  title: Text(option),
                  trailing: selectedValue == option
                      ? Icon(Icons.check_circle, color: context.colorsX.primary)
                      : null,
                  onTap: () => context.pop(option),
                ),
            ],
          ),
        );
      },
    ).then((selectedOption) {
      if (selectedOption != null) {}
    });
  }
}
