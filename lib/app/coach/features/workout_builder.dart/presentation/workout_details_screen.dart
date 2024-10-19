part of 'workout_builder_screen.dart';

class _WkDetails extends StatelessWidget {
  const _WkDetails();

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('New Workout'),
      ),
      body: Column(
        children: [
          const Gap(30),
          TextField(
            controller: context.wkBuilderCubit.workoutName,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const Gap(30),
          TextField(
            maxLines: 5,
            controller: context.wkBuilderCubit.workoutDesc,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: context.wkBuilderCubit.state.exercises.isNotEmpty
          ? Button.filled(
              label: 'Continue',
              density: ButtonDensity.comfortable,
              onPressed: () => context.wkBuilderCubit.pageController.nextPage(
                duration: Default.duration,
                curve: Default.curve,
              ),
            )
          : Button.filled(
              label: 'Add Exercises',
              density: ButtonDensity.comfortable,
              onPressed: () async {
                final exercises = await ExercisePicker.show(context);
                if (exercises == null || !context.mounted) return;
                context.wkBuilderCubit.addExercises(exercises);
                context.wkBuilderCubit.pageController.jumpToPage(1);
              },
            ),
    );
  }
}
