part of 'workout_builder_screen.dart';

class _ExerciseDetailsScreen extends StatelessWidget {
  const _ExerciseDetailsScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBuilderCubit, WorkoutBuilderState>(
      builder: (context, state) {
        return Screen(
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
          body: ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) {},
            itemCount: state.exercises.length,
            itemBuilder: (context, i) => _Exercise(
              excIndex: i,
              key: Key(i.toString()),
              reordering: state.reordering,
            ),
          ),
        );
      },
    );
  }
}

class _Exercise extends StatelessWidget {
  final int excIndex;
  final bool reordering;
  const _Exercise({required this.excIndex, this.reordering = false, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WorkoutBuilderCubit, WorkoutBuilderState, ExerciseDetails>(
      selector: (state) => state.exercises[excIndex],
      builder: (context, excDetails) {
        return Column(
          children: [
            InkWell(
              onLongPress: () {
                context.wkBuilderCubit.startOrderingExc();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.colorsX.secondaryBackground,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: reordering ? 15 : 25),
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
                              imageUrl: excDetails.exercise.mockImage,
                            ),
                          ),
                          const Gap(15),
                          Text(
                            excDetails.exercise.name,
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
                      Row(
                        children: [
                          const _Header('Set'),
                          for (final field in excDetails.exercise.fieldTypes)
                            switch (field) {
                              FieldType.reps => const _Header('Reps'),
                              FieldType.time => const _Header('Time'),
                              FieldType.weight => const _Header('Weight'),
                              FieldType.distance => const _Header('Distance'),
                            }
                        ],
                      ),
                      const Gap(15),
                      const Divider(height: 0, indent: 18, endIndent: 18),
                      const Gap(9),
                      for (final row in excDetails.fields.entries)
                        Dismissible(
                          key: UniqueKey(),
                          direction: row.key.value == 1 ? DismissDirection.none : DismissDirection.endToStart,
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
                                        final duration = await showDurationPicker(context: context, initialTime: field.value);
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 5, right: 9),
                        child: Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                value: false,
                                onChanged: (value) {},
                                title: const Text('Each side'),
                                contentPadding: EdgeInsets.zero,
                                controlAffinity: ListTileControlAffinity.leading,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: TextButton.icon(
                                  icon: const Icon(Icons.add),
                                  label: const Text('Add set'),
                                  onPressed: () => context.wkBuilderCubit.addSet(excIndex),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const Divider(
              height: 50,
              indent: 15,
              endIndent: 15,
            ),
          ],
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
