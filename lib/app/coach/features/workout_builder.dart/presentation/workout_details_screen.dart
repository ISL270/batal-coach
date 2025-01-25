part of 'workout_builder_screen.dart';

class _WkDetails extends StatelessWidget {
  const _WkDetails();

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: Text(context.l10n.newWorkout),
      ),
      body: Column(
        children: [
          const Gap(30),
          BlocSelector<WorkoutBuilderCubit, WorkoutBuilderState, String>(
            selector: (state) => state.name,
            builder: (context, name) {
              return TextFormField(
                initialValue: name,
                onChanged: context.wkBuilderCubit.updateName,
                decoration:
                    InputDecoration(labelText: context.l10n.workoutName),
              );
            },
          ),
          const Gap(30),
          BlocSelector<WorkoutBuilderCubit, WorkoutBuilderState, String?>(
            selector: (state) => state.description.value,
            builder: (context, description) {
              return TextFormField(
                maxLines: 5,
                initialValue: description,
                onChanged: context.wkBuilderCubit.updateDescription,
                decoration: InputDecoration(labelText: context.l10n.workoutDes),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          BlocBuilder<WorkoutBuilderCubit, WorkoutBuilderState>(
        builder: (context, state) {
          if (state.exercisesSets.isNotEmpty) {
            return Button.filled(
              label: context.l10n.continu,
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
            label: context.l10n.addExercises,
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
