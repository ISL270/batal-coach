import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/coach/features/workout_builder.dart/presentation/bloc/wk_builder_bloc.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/extensions/duration_x.dart';
import 'package:btl/app/core/extensions/text_style_x.dart';
import 'package:btl/app/core/models/domain/field.dart';
import 'package:btl/app/core/models/domain/length_unit.dart';
import 'package:btl/app/core/models/domain/mass_unit.dart';
import 'package:btl/app/core/models/domain/set.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/number_picker_bs.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class WorkoutBuilderScreen extends StatelessWidget {
  static const name = 'workout_builder';

  const WorkoutBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(),
      body: BlocBuilder<WkBuilderBloc, WkBuilderState>(
        builder: (context, state) => switch (state.status) {
          Loading<void>() => const Center(child: CircularProgressIndicator()),
          Success<void>() => ListView.separated(
              itemCount: state.exercises.length,
              itemBuilder: (context, i) => _Exercise(state.exercises[i]),
              separatorBuilder: (context, index) =>
                  const Divider(indent: 15, endIndent: 15, height: 50),
            ),
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }
}

class _Exercise extends StatefulWidget {
  final Exercise exercise;
  const _Exercise(this.exercise);

  @override
  State<_Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<_Exercise> {
  Map<SET, List<Field>> _fields = {};

  @override
  void initState() {
    _fields[Regular.first()] = widget.exercise.initialFields();
    super.initState();
  }

  void resetSetsOrder() {
    final newFields = <SET, List<Field>>{};
    for (var i = 0; i < _fields.length; i++) {
      newFields[_fields.entries.elementAt(i).key.copyWith(i + 1)] =
          _fields.entries.elementAt(i).value;
    }
    _fields = newFields;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: context.colorsX.secondaryBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 25),
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
                    imageUrl: widget.exercise.mockImage,
                  ),
                ),
                const Gap(15),
                Text(
                  widget.exercise.name,
                  style: context.textThemeX.small.bold,
                ),
              ],
            ),
          ),
          Row(
            children: [
              const _Header('Set'),
              for (final field in widget.exercise.fields)
                switch (field) {
                  FieldType.time => const _Header('Time'),
                  FieldType.distance => const _Header('Distance'),
                  FieldType.weight => const _Header('Weight'),
                  FieldType.reps => const _Header('Reps'),
                }
            ],
          ),
          const Gap(15),
          const Divider(height: 0, indent: 18, endIndent: 18),
          const Gap(9),
          for (final row in _fields.entries)
            Dismissible(
              key: ValueKey(row.key),
              direction: row.key.value == 1 ? DismissDirection.none : DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  _fields.remove(row.key);
                  resetSetsOrder();
                });
              },
              background: Container(
                color: Colors.red,
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
                            if (duration == null) return;
                            setState(() {
                              final i = _fields[row.key]?.indexWhere((e) => e.isTime);
                              if (i == null) return;
                              _fields[row.key]?[i] = Time(duration);
                            });
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
                            if (distance == null) return;
                            setState(() {
                              final i = _fields[row.key]?.indexWhere((e) => e.isDistance);
                              if (i == null) return;
                              _fields[row.key]?[i] = Distance(Kilometer(distance));
                            });
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
                            if (weight == null) return;
                            setState(() {
                              final i = _fields[row.key]?.indexWhere((e) => e.isWeight);
                              if (i == null) return;
                              _fields[row.key]?[i] = Weight(Kilogram(weight));
                            });
                          },
                        ),
                      Reps() => _Cell(
                          field.value.toString(),
                          onTap: () async {
                            final reps = await NumberPickerBS.show(
                              context,
                              initial: field.value.toDouble(),
                            );
                            if (reps == null) return;
                            setState(() {
                              final i = _fields[row.key]?.indexWhere((e) => e.isReps);
                              if (i == null) return;
                              _fields[row.key]?[i] = Reps(reps.toInt());
                            });
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
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton.icon(
                      onPressed: () => setState(() {
                        _fields[Regular(_fields.keys.last.value + 1)] =
                            widget.exercise.initialFields();
                      }),
                      label: const Text('Add set'),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                )
              ],
            ),
          )
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
