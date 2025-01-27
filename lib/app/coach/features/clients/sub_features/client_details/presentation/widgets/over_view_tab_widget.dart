part of '../client_details_screen.dart';

class _OverViewTab extends StatelessWidget {
  const _OverViewTab();

  @override
  Widget build(BuildContext context) {
    return Material(
      surfaceTintColor: context.colorsX.primary,
      color: context.colorsX.onBackground.withValues(alpha: 0.05),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
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
              _OverviewCard(
                title: context.l10n.workoutTitle,
                subTitle: context.l10n.noWorkout,
                image: Assets.icons.dumbbell,
                onTap: () => context.pushNamed(ClientTasksScreen.name),
              ),
              SizedBox(height: 10.h),
              _OverviewCard(
                title: context.l10n.tasks,
                subTitle: context.l10n.noTasks,
                image: Assets.icons.checklist,
                onTap: () => context.pushNamed(ClientTasksScreen.name),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Row(
                  children: [
                    Text(
                      context.l10n.metrics,
                      style: context.textThemeX.large.bold,
                    ),
                    const Spacer(),
                    TextButton(onPressed: () {}, child: Text(context.l10n.viewMore)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  children: [
                    _MetricsWidget(
                      title: context.l10n.weight,
                      subTitle: context.l10n.noData,
                      image: Assets.icons.weight,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    _MetricsWidget(
                      title: context.l10n.fat,
                      subTitle: context.l10n.noData,
                      image: Assets.icons.fat,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({
    required this.title,
    required this.subTitle,
    required this.image,
    this.onTap,
  });

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
            borderRadius: BorderRadius.circular(8.sp)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: ListTile(
            leading: Padding(
              padding: EdgeInsets.all(8.w),
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
              style: context.textThemeX.large.bold.copyWith(fontSize: 20.sp),
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

class _MetricsWidget extends StatelessWidget {
  const _MetricsWidget({
    required this.title,
    required this.subTitle,
    required this.image,
  });

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
                style: context.textThemeX.small.copyWith(color: context.colorsX.onBackgroundTint),
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
