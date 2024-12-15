part of '../exercise_details_screen.dart';

class FirstPageView extends StatelessWidget {
  const FirstPageView({
    required this.pageViewController,
    super.key,
  });

  final PageController pageViewController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(15),
          Row(
            children: [
              const _exerciseDetailsBodyTitle(
                text: 'Weighted Crunches',
              ),
              const Spacer(),
              Button.filled(
                label: 'Setup',
                iconWithAlignment: const IconWithAlignment(
                  Icon(FontAwesomeIcons.arrowRight, size: 18),
                  alignment: IconAlignment.end,
                ),
                onPressed: () => pageViewController.nextPage(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutCirc,
                ),
              )
            ],
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleWithASubTitleBehind(
                title: 'Main Muscle',
                subTitle: 'Shoulders',
              ),
              Gap(10),
              _titleWithASubTitleBehind(
                title: 'Secondary Muscle',
                subTitle: 'Chest',
              ),
              Gap(10),
              _exerciseDtailsBodySubTitle('Force'),
              Gap(10),
              _generatedCircularContainer(
                options: [
                  'Pull',
                  'Push',
                  'Static',
                ],
                activeOption: 0,
              ),
              Gap(20),
              _exerciseDtailsBodySubTitle('Level'),
              Gap(10),
              _generatedCircularContainer(
                options: [
                  'beginner',
                  'intermediate',
                  'expert',
                ],
                activeOption: 1,
              ),
              Gap(20),
              _exerciseDtailsBodySubTitle('Type'),
              Gap(10),
              _generatedCircularContainer(
                options: [
                  'Distance',
                  'Timed',
                  'Body Weight',
                  'Strength',
                ],
                activeOption: 3,
              ),
              Gap(20),
              _exerciseDtailsBodySubTitle('Mechanic'),
              Gap(10),
              _generatedCircularContainer(
                options: ['Isolation', 'Compound'],
                activeOption: 0,
              ),
              Gap(20),
            ],
          ),
        ],
      ),
    );
  }
}
