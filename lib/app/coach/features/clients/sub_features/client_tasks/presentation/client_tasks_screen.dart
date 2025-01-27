import 'package:btl/app/core/assets_gen/assets.gen.dart';
import 'package:btl/app/core/extension_methods/date_x.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

part 'widgets/week_selection_widget.dart';

class ClientTasksScreen extends StatelessWidget {
  const ClientTasksScreen({super.key});

  static const name = 'clientTasksScreen';

  @override
  Widget build(BuildContext context) {
    return Screen(
      padding: EdgeInsets.zero,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.colorsX.onBackground.withValues(alpha: 0.01),
        title: Text(context.l10n.tasks, style: context.textThemeX.large),
      ),
      body: Material(
        surfaceTintColor: context.colorsX.primary,
        color: context.colorsX.onBackground.withValues(alpha: 0.01),
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Row(
                  children: [
                    _TasksHeaderCard(
                      title: context.l10n.last7days,
                      fraction: ''
                          '0/0',
                    ),
                    SizedBox(width: 20.w),
                    _TasksHeaderCard(
                      title: context.l10n.last14days,
                      fraction: '0/0',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(color: context.colorsX.secondaryBackground),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    const _WeekSelector(),
                    const Spacer(flex: 2),
                    SvgPicture.asset(
                      Assets.illustrations.notes,
                      width: 250.w,
                    ),
                    Text(
                      context.l10n.noAssignedTasks,
                      style: context.textThemeX.medium
                          .copyWith(color: context.colorsX.onBackgroundTint35),
                    ),
                    const Spacer(flex: 3),
                    Button.filled(
                      onPressed: () => showTaskBottomSheet(
                        context,
                        context.l10n.selectType,
                        [
                          context.l10n.bodyMetrics,
                          context.l10n.progressPhoto,
                          context.l10n.general,
                        ],
                      ),
                      label: context.l10n.createTask,
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showTaskBottomSheet(BuildContext context, String label, List<String> options) {
    showModalBottomSheet<dynamic>(
      backgroundColor: context.colorsX.secondaryBackground,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: context.textThemeX.medium.bold,
              ),
              SizedBox(height: 16.h),
              for (final String option in options)
                ListTile(
                  title: Text(option),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: context.colorsX.primary,
                  ),
                  onTap: () => context.pop(option),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _TasksHeaderCard extends StatelessWidget {
  const _TasksHeaderCard({
    required this.title,
    required this.fraction,
  });

  final String title;
  final String fraction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: context.colorsX.secondaryBackground,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                title,
                style: context.textThemeX.medium.copyWith(
                  color: context.colorsX.onBackgroundTint35,
                ),
              ),
              Text(
                fraction,
                style: context.textThemeX.heading.bold,
              ),
              Text(
                context.l10n.tracked,
                style: context.textThemeX.small.copyWith(
                  color: context.colorsX.onBackgroundTint35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
