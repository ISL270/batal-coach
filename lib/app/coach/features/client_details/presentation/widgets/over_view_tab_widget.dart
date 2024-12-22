import 'package:btl/app/coach/features/client_details/presentation/widgets/metrics_widget.dart';
import 'package:btl/app/coach/features/client_details/presentation/widgets/overview_card.dart';
import 'package:btl/app/core/assets_gen/assets.gen.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverViewTab extends StatelessWidget {
  const OverViewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      surfaceTintColor: context.colorsX.primary,
      color: context.colorsX.onBackground.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  context.l10n.training,
                  style: context.textThemeX.large.bold,
                ),
              ),
              OverviewCard(
                title: context.l10n.workoutTitle,
                subTitle: context.l10n.noWorkout,
                image: Assets.icons.dumbbell,
                onTap: () {
                  // context.pushNamed(ClientTasksScreen.name);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              OverviewCard(
                title: context.l10n.tasks,
                subTitle: context.l10n.noTasks,
                image: Assets.icons.checklist,
                onTap: () {
                  // context.pushNamed(ClientTasksScreen.name);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    Text(
                      context.l10n.metrics,
                      style: context.textThemeX.large.bold,
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {}, child: Text(context.l10n.viewMore)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    MetricsWidget(
                      title: context.l10n.weight,
                      subTitle: context.l10n.noData,
                      image: Assets.icons.weight,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    MetricsWidget(
                      title: context.l10n.fat,
                      subTitle: context.l10n.noData,
                      image: Assets.icons.fat,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
