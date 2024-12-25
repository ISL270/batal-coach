part of 'workout_builder_screen.dart';

class _ExercisesSetsScreen extends StatelessWidget {
  const _ExercisesSetsScreen();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WorkoutBuilderCubit, WorkoutBuilderState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.pop();
        }
      },
      builder: (context, state) {
        return Screen(
          safeAreaValues: const SafeAreaValues(bottom: false),
          appBar: AppBar(
            title: Text(state.name),
            leading: const SizedBox.shrink(),
            actions: [
              IconButton(
                iconSize: 33.r,
                icon: const Icon(Icons.keyboard_arrow_up),
                padding: const EdgeInsetsDirectional.only(end: 22),
                onPressed: () => context.wkBuilderCubit.pageController.previousPage(
                  duration: Default.duration,
                  curve: Default.curve,
                ),
              )
            ],
          ),
          body: ListView.separated(
            itemCount: state.exercisesSets.length,
            padding: EdgeInsets.only(bottom: .085.sh),
            itemBuilder: (context, i) => _Exercise(excIndex: i),
            separatorBuilder: (context, index) => const Divider(
              indent: 15,
              endIndent: 15,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Button.filled(
            density: ButtonDensity.comfortable,
            isLoading: state.status.isLoading,
            onPressed: context.wkBuilderCubit.saveWorkout,
            label: 'Save',
          ),
        );
      },
    );
  }
}

class _Exercise extends StatelessWidget {
  final int excIndex;
  final bool reordering;
  // ignore: unused_element
  const _Exercise({required this.excIndex, this.reordering = false});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WorkoutBuilderCubit, WorkoutBuilderState, ExerciseSets>(
      selector: (state) => state.exercisesSets[excIndex],
      builder: (context, exerciseSets) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: context.colorsX.secondaryBackground,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: context.colorsX.background,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        height: 40,
                        imageUrl: exerciseSets.exercise.mockImage,
                      ),
                    ),
                    const Gap(15),
                    Text(
                      exerciseSets.exercise.name,
                      style: context.textThemeX.small.bold,
                    ),
                    if (reordering) ...[
                      const Spacer(),
                      ReorderableDragStartListener(
                        key: key,
                        index: excIndex,
                        child: const Icon(Icons.drag_handle_rounded),
                      ),
                    ],
                  ],
                ),
              ),
              if (!reordering) ...[
                const Gap(15),
                Row(
                  children: [
                    const _Header('Set'),
                    for (final field in exerciseSets.exercise.fieldTypes)
                      switch (field) {
                        FieldType.reps => const _Header('Reps'),
                        FieldType.time => const _Header('Time'),
                        FieldType.weight => const _Header('Weight'),
                        FieldType.distance => const _Header('Distance'),
                      }
                  ],
                ),
                const Gap(15),
                const Divider(height: 0),
                const Gap(9),
                for (final row in exerciseSets.fields.entries)
                  Dismissible(
                    key: UniqueKey(),
                    direction:
                        row.key.value == 1 ? DismissDirection.none : DismissDirection.endToStart,
                    onDismissed: (direction) => context.wkBuilderCubit.removeSet(excIndex, row.key),
                    background: Container(
                      color: context.colorsX.error,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Center(child: Text(row.key.value.toString()))),
                        for (final field in row.value)
                          switch (field) {
                            Time() => _Cell(
                                field.value.toHHMM(),
                                onTap: () async {
                                  final duration = await showDurationPicker(
                                      context: context, initialTime: field.value);
                                  if (duration == null || !context.mounted) return;
                                  context.wkBuilderCubit.updateField(
                                    excIndex,
                                    row.key,
                                    Time(duration),
                                  );
                                },
                              ),
                            Distance() => _Cell(
                                field.value.toString(),
                                onTap: () async {
                                  final distance = await NumberPickerBS.show(
                                    context,
                                    isDecimal: true,
                                    initial: field.value.value,
                                  );
                                  if (distance == null || !context.mounted) return;
                                  context.wkBuilderCubit.updateField(
                                    excIndex,
                                    row.key,
                                    Distance(Kilometer(distance.roundTo())),
                                  );
                                },
                              ),
                            Weight() => _Cell(
                                field.value.toString(),
                                onTap: () async {
                                  final weight = await NumberPickerBS.show(
                                    context,
                                    isDecimal: true,
                                    initial: field.value.value,
                                  );
                                  if (weight == null || !context.mounted) return;
                                  context.wkBuilderCubit.updateField(
                                    excIndex,
                                    row.key,
                                    Weight(Kilogram(weight.roundTo())),
                                  );
                                },
                              ),
                            Reps() => _Cell(
                                field.value.toString(),
                                onTap: () async {
                                  final reps = await NumberPickerBS.show(
                                    context,
                                    initial: field.value.toDouble(),
                                  );
                                  if (reps == null || !context.mounted) return;
                                  context.wkBuilderCubit.updateField(
                                    excIndex,
                                    row.key,
                                    Reps(reps.toInt()),
                                  );
                                },
                              ),
                          }
                      ],
                    ),
                  ),
                const Gap(5),
                Button.outlined(
                  height: 2,
                  label: 'Add set',
                  density: ButtonDensity.compact,
                  onPressed: () => context.wkBuilderCubit.addSet(excIndex),
                  iconWithAlignment: const IconWithAlignment(Icon(Icons.add, size: 22)),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  const _Header(this.title);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Center(child: Text(title, style: context.textThemeX.small.bold)));
  }
}

class _Cell extends StatelessWidget {
  final String value;
  final VoidCallback onTap;
  const _Cell(this.value, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 40,
          child: Center(child: Text(value, style: context.textThemeX.small)),
        ),
      ),
    );
  }
}
