part of 'workout_builder_screen.dart';

class _WkDetails extends StatelessWidget {
  const _WkDetails();

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('New Workout'),
      ),
      body: const Column(
        children: [
          Gap(30),
          TextField(
            decoration: InputDecoration(labelText: 'Name'),
          ),
          Gap(30),
          TextField(
            maxLines: 5,
            decoration: InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      floatingActionButton: context.read<WorkoutBuilderCubit>().state.exercises.isNotEmpty
          ? Button.filled(
              label: 'Continue',
              density: ButtonDensity.comfortable,
              onPressed: () async {
                context.read<WorkoutBuilderCubit>().pageController.jumpToPage(1);
              },
            )
          : Button.filled(
              label: 'Add Exercises',
              density: ButtonDensity.comfortable,
              onPressed: () async {
                final exercises = await ExercisePicker.show(context);
                if (exercises == null || !context.mounted) return;
                context.read<WorkoutBuilderCubit>().addExercises(exercises);
                context.read<WorkoutBuilderCubit>().pageController.jumpToPage(1);
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
