part of 'workout_builder_screen.dart';

class _ExercisesSetsScreen extends StatefulWidget {
  const _ExercisesSetsScreen();

  @override
  State<_ExercisesSetsScreen> createState() => _ExercisesSetsScreenState();
}

class _ExercisesSetsScreenState extends State<_ExercisesSetsScreen> {
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
                onPressed: () =>
                    context.wkBuilderCubit.pageController.previousPage(
                  duration: Default.duration,
                  curve: Default.curve,
                ),
              ),
            ],
          ),
          body: ReorderableListView.builder(
            key: const Key('ReorderableListView'),
            onReorderStart: (_) =>
                context.read<WorkoutBuilderCubit>().startReordering(),
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) newIndex -= 1;
              context.read<WorkoutBuilderCubit>().reorderExercise(
                    oldIndex,
                    newIndex,
                  );
            },
            onReorderEnd: (_) =>
                context.read<WorkoutBuilderCubit>().finishReordering(),
            itemCount: state.exercisesSets.length,
            padding: EdgeInsets.only(bottom: .085.sh),
            itemBuilder: (context, i) => _Exercise(
              key: ValueKey(state.exercisesSets[i].exercise.id),
              excIndex: i,
              exerciseSets: state.exercisesSets[i],
              isReordering: state.reordering, // Pass the reordering state
            ),
            proxyDecorator: (child, index, animation) {
              return _Exercise(
                key: ValueKey(state.exercisesSets[index].exercise.id),
                excIndex: index,
                exerciseSets: state.exercisesSets[index],
                isReordering: true, // Pass the reordering state
              );
            },
          ),
        );
      },
    );
  }
}

class _Exercise extends StatelessWidget {
  final int excIndex;
  final ExerciseSets exerciseSets;
  final bool isReordering;

  const _Exercise({
    required Key key,
    required this.excIndex,
    required this.exerciseSets,
    required this.isReordering,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      tween: Tween<double>(begin: 1, end: isReordering ? 0.9 : 1.0),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: context.colorsX.secondaryBackground,
              border: isReordering
                  ? Border.all(
                      color: context.colorsX.secondaryBackground,
                      width: 4,
                    )
                  : null,
            ),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ExerciseWidgetHeader(
            imageUrl: exerciseSets.exercise.mockImage,
            name: exerciseSets.exercise.name,
          ),
          if (!isReordering) ...[
            const Gap(15),
            Row(
              children: [
                _Header(context.l10n.set),
                for (final field in exerciseSets.exercise.fieldTypes)
                  switch (field) {
                    FieldType.reps => _Header(context.l10n.reps),
                    FieldType.time => _Header(context.l10n.time),
                    FieldType.weight => _Header(context.l10n.weight),
                    FieldType.distance => _Header(context.l10n.distance),
                  },
              ],
            ),
            const Gap(15),
            const Divider(height: 0),
            const Gap(9),
            for (final row in exerciseSets.fields.entries)
              Dismissible(
                key: UniqueKey(),
                direction: row.key.value == 1
                    ? DismissDirection.none
                    : DismissDirection.endToStart,
                onDismissed: (direction) =>
                    context.wkBuilderCubit.removeSet(excIndex, row.key),
                background: Container(
                  color: context.colorsX.error,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Center(child: Text(row.key.value.toString()))),
                    for (final field in row.value)
                      switch (field) {
                        Time() => _Cell(
                            field.value.toHHMM(),
                            onTap: () async {
                              final duration = await showDurationPicker(
                                  context: context, initialTime: field.value);
                              if (duration == null || !context.mounted) {
                                return;
                              }
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
                              if (distance == null || !context.mounted) {
                                return;
                              }
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
                              if (weight == null || !context.mounted) {
                                return;
                              }
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
                              if (reps == null || !context.mounted) {
                                return;
                              }
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
              label: context.l10n.addSet,
              density: ButtonDensity.compact,
              onPressed: () => context.wkBuilderCubit.addSet(excIndex),
              iconWithAlignment:
                  const IconWithAlignment(Icon(Icons.add, size: 22)),
            ),
          ]
        ],
      ),
    );
  }
}

class _ExerciseWidgetHeader extends StatelessWidget {
  const _ExerciseWidgetHeader({
    required this.imageUrl,
    required this.name,
  });

  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.colorsX.onBackground.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                height: 40.h,
                width: 40.w,
                imageUrl: imageUrl,
              ),
            ),
          ),
          const Gap(15),
          Text(
            name,
            style: context.textThemeX.small.bold,
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;

  const _Header(this.title);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:
            Center(child: Text(title, style: context.textThemeX.small.bold)));
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
