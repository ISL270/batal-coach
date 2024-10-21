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
          BlocSelector<WorkoutBuilderCubit, WorkoutBuilderState, String>(
            selector: (state) => state.name,
            builder: (context, name) {
              return TextField(
                onChanged: context.wkBuilderCubit.updateName,
                decoration: const InputDecoration(labelText: 'Name'),
              );
            },
          ),
          const Gap(30),
          BlocSelector<WorkoutBuilderCubit, WorkoutBuilderState, String?>(
            selector: (state) => state.description.value,
            builder: (context, description) {
              return TextField(
                maxLines: 5,
                onChanged: context.wkBuilderCubit.updateDescription,
                decoration: const InputDecoration(labelText: 'Description'),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<WorkoutBuilderCubit, WorkoutBuilderState>(
        builder: (context, state) {
          if (state.exercises.isNotEmpty) {
            return Button.filled(
              label: 'Continue',
              density: ButtonDensity.comfortable,
              onPressed: state.name.isBlank
                  ? null
                  : () => context.wkBuilderCubit.pageController.nextPage(
                        duration: Default.duration,
                        curve: Default.curve,
                      ),
            );
          }
          return Button.filled(
            label: 'Add Exercises',
            density: ButtonDensity.comfortable,
            onPressed: state.name.isBlank
                ? null
                : () async {
                    final exercises = await ExercisePicker.show(context);
                    if (exercises == null || !context.mounted) return;
                    context.wkBuilderCubit.addExercises(exercises);
                    context.wkBuilderCubit.pageController.jumpToPage(1);
                  },
          );
        },
      ),
    );
  }
}
