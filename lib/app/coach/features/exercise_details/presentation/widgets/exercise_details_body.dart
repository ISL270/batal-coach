part of '../exercise_details_screen.dart';

class _ExerciseDetailsBody extends StatelessWidget {
  const _ExerciseDetailsBody(this.exercise);

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(10.h),
          _TitleWithASubTitleBehind(
            title: context.l10n.mainMuscle,
            subTitle: exercise.mainMuscle.name,
          ),
          _TitleWithASubTitleBehind(
            title: context.l10n.secondaryMuscle,
            subTitle: exercise.secondaryMuscles.isNotEmpty
                ? exercise.secondaryMuscles.map((muscle) => muscle.name).join(', ')
                : 'N/A', // Use a default message when empty
          ),
          _TitleWithASubTitleBehind(
            title: context.l10n.force,
            subTitle: exercise.force?.name ?? 'N/A',
          ),
          _TitleWithASubTitleBehind(
            title: context.l10n.type,
            subTitle: exercise.type?.name ?? 'N/A',
          ),
          _TitleWithASubTitleBehind(
            title: context.l10n.level,
            subTitle: exercise.type?.name ?? 'N/A',
          ),
          _TitleWithASubTitleBehind(
            title: context.l10n.mechanic,
            subTitle: exercise.mechanic?.name ?? 'N/A',
          ),
          _TitleWithASubTitleBehind(
            title: context.l10n.equipment,
            subTitle: exercise.equipment?.name ?? 'N/A',
          ),
          Gap(5.h),
          Text(
            context.l10n.exerciseDetails,
            textAlign: TextAlign.center,
            style: context.textThemeX.large.bold,
          ),
          Gap(5.h),
          BlocBuilder<ExerciseDetailsCubit, ExerciseDetailsState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(8.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    exercise.instructions.length,
                    (index) => _SetupLine(
                      index: index,
                      text: exercise.instructions[index],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TitleWithASubTitleBehind extends StatelessWidget {
  const _TitleWithASubTitleBehind({required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final capitalizedSubTitle =
        subTitle.isNotEmpty ? subTitle[0].toUpperCase() + subTitle.substring(1) : subTitle;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(title, style: context.textThemeX.medium.bold),
        const Spacer(),
        Text(
          capitalizedSubTitle,
          style: context.textThemeX.medium.bold
              .copyWith(color: context.colorsX.primary, textBaseline: TextBaseline.ideographic),
        ),
      ],
    );
  }
}

class _SetupLine extends StatelessWidget {
  const _SetupLine({required this.text, required this.index});

  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text('${index + 1}. ', style: context.textThemeX.medium),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: context.textThemeX.medium.copyWith(
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
              Gap(5.h),
            ],
          ),
        ),
      ],
    );
  }
}
