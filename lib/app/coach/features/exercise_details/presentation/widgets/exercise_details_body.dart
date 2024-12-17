part of '../exercise_details_screen.dart';

class _ExerciseDetailsBody extends StatelessWidget {
  const _ExerciseDetailsBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          const _TitleWithASubTitleBehind(
            title: 'Main Muscle',
            subTitle: 'Shoulders',
          ),
          const Gap(10),
          const _TitleWithASubTitleBehind(
            title: 'Secondary Muscle',
            subTitle: 'Chest',
          ),
          const Gap(10),
          const _TitleWithASubTitleBehind(
            title: 'Force',
            subTitle: 'Push',
          ),
          const Gap(10),
          const _TitleWithASubTitleBehind(
            title: 'Type',
            subTitle: 'Body weight',
          ),
          const Gap(10),
          const _TitleWithASubTitleBehind(
            title: 'Level',
            subTitle: 'intermediate',
          ),
          const Gap(10),
          const _TitleWithASubTitleBehind(
            title: 'Mechanic',
            subTitle: 'isolation',
          ),
          const Gap(10),
          const _TitleWithASubTitleBehind(
            title: 'Equipment',
            subTitle: 'Dumbbell',
          ),
          const Gap(15),
          const _ExerciseDetailsBodyTitle(text: 'Exercise Description'),
          const Gap(5),
          BlocBuilder<ExerciseDetailsCubit, ExerciseDetailsState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    state.setupLines.length,
                    (index) => _SetupLine(
                      index: index,
                      text: state.setupLines[index],
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(title, style: context.textThemeX.medium.bold),
        const Spacer(),
        Text(
          subTitle,
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
              const Gap(5),
            ],
          ),
        ),
      ],
    );
  }
}

class _ExerciseDetailsBodyTitle extends StatelessWidget {
  const _ExerciseDetailsBodyTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: TextAlign.center, style: context.textThemeX.large.bold);
  }
}
