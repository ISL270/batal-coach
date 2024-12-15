part of '../exercise_details_screen.dart';

class SecondPageView extends StatelessWidget {
  const SecondPageView({required this.setupLines, super.key});

  final List<String> setupLines;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(15),
          const _exerciseDetailsBodyTitle(text: 'Setup for a Weighted Crunches'),
          const Gap(5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              setupLines.length,
              (index) => _setupLine(
                text: setupLines[index],
              ),
            ),
          ),
          const Gap(10),
          const _exerciseDtailsBodySubTitle('Equipment'),
          const Gap(10),
          const _generatedCircularContainer(
            options: [
              'barbell',
              'dumbbell',
              'cable',
              'machine',
              'kettlebells',
              'bands',
              'medicineBall',
              'foamRoll',
              'ezCurlBar',
              'bodyOnly',
              'exerciseBall',
              'other',
            ],
            activeOption: 1,
          ),
          const Gap(20),
        ],
      ),
    );
  }
}

class _setupLine extends StatelessWidget {
  const _setupLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: context.textThemeX.medium,
        ),
        const Gap(5),
      ],
    );
  }
}
