part of 'package:btl/app/coach/features/exercise/presentation/exercises_screen.dart';

class _FilterBottomSheet extends StatefulWidget {
  const _FilterBottomSheet();

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  late final ExFilters filters;

  @override
  void initState() {
    super.initState();
    filters = context.read<ExercisesBloc>().state.filters.clone();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      backgroundColor: context.colorsX.secondaryBackground,
      builder: (context) => Stack(
        children: [
          CustomScrollView(
            slivers: [
              PinnedHeaderSliver(
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colorsX.secondaryBackground,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(child: Text('Filter by', style: context.textThemeX.large.bold)),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                          onPressed: context.read<ExercisesBloc>().state.filters.isEmpty
                              ? null
                              : () {
                                  context.read<ExercisesBloc>().add(ExFiltered(ExFilters()));
                                  context.pop();
                                },
                          child: const Text('Reset'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 15, right: 20, left: 20, bottom: 100.h),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      Text(
                        'Excercises From',
                        style: context.textThemeX.medium.bold,
                      ),
                      const Gap(5),
                      SegmentedButton(
                        selected: filters.owership,
                        showSelectedIcon: false,
                        multiSelectionEnabled: true,
                        onSelectionChanged: (selection) => setState(() {
                          filters.owership.clear();
                          filters.owership.addAll(selection);
                        }),
                        segments: [
                          ButtonSegment(
                            value: ExOwnership.btl,
                            label: Text(context.l10n.btl),
                          ),
                          ButtonSegment(
                            value: ExOwnership.personal,
                            label: Text(context.l10n.personal.capitalized),
                          ),
                        ],
                        style: SegmentedButton.styleFrom(
                          textStyle: context.textThemeX.small.bold,
                          visualDensity: VisualDensity.compact,
                        ),
                      ),
                      const Seperator(),
                      _Filter(
                        title: 'Muscles',
                        values: Muscle.values,
                        initialValues: filters.muscles,
                        onSelected: (selected, v) {
                          setState(() {
                            if (selected) {
                              filters.muscles.add(v);
                            } else {
                              filters.muscles.remove(v);
                            }
                          });
                        },
                      ),
                      const Seperator(),
                      _Filter(
                        title: 'Equipment',
                        values: Equipment.values,
                        initialValues: filters.equipment,
                        onSelected: (selected, v) {
                          setState(() {
                            if (selected) {
                              filters.equipment.add(v);
                            } else {
                              filters.equipment.remove(v);
                            }
                          });
                        },
                      ),
                      const Seperator(),
                      _Filter(
                        title: 'Categories',
                        values: ExCategory.values,
                        initialValues: filters.category,
                        onSelected: (selected, v) {
                          setState(() {
                            if (selected) {
                              filters.category.add(v);
                            } else {
                              filters.category.remove(v);
                            }
                          });
                        },
                      ),
                      const Seperator(),
                      _Filter(
                        title: 'Level',
                        values: ExLevel.values,
                        initialValues: filters.level,
                        onSelected: (selected, v) {
                          setState(() {
                            if (selected) {
                              filters.level.add(v);
                            } else {
                              filters.level.remove(v);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(bottom: 33.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    context.colorsX.secondaryBackground.withOpacity(0),
                    context.colorsX.secondaryBackground,
                  ],
                ),
              ),
              child: UnconstrainedBox(
                child: Button.filled(
                  onPressed: () {
                    if (!filters.isEmpty) {
                      context.read<ExercisesBloc>().add(ExFiltered(filters));
                    }
                    context.pop();
                  },
                  label: 'Apply filter',
                  density: ButtonDensity.comfortable,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Filter<E extends Enum> extends StatefulWidget {
  final String title;
  final List<E> values;
  final Set<E> initialValues;
  final void Function(bool, E) onSelected;

  const _Filter({
    required this.title,
    required this.values,
    required this.onSelected,
    required this.initialValues,
  });

  @override
  State<_Filter<E>> createState() => _FilterState<E>();
}

class _FilterState<E extends Enum> extends State<_Filter<E>> {
  late final Set<E> _selectedValues;

  @override
  void initState() {
    _selectedValues = widget.initialValues;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: context.textThemeX.medium.bold,
        ),
        const Gap(8),
        Wrap(
          spacing: 11,
          children: widget.values
              .map((v) => FilterChip(
                    label: Text(context.tr(v.name)),
                    onSelected: (selected) {
                      widget.onSelected(selected, v);
                      setState(() {
                        if (selected) {
                          _selectedValues.add(v);
                        } else {
                          _selectedValues.remove(v);
                        }
                      });
                    },
                    selected: _selectedValues.contains(v),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
