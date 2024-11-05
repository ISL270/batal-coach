part of 'package:btl/app/coach/features/exercises/presentation/exercises_screen.dart';

class ExcFilterBottomSheet extends StatefulWidget {
  const ExcFilterBottomSheet({super.key});

  @override
  State<ExcFilterBottomSheet> createState() => _ExcFilterBottomSheetState();
}

class _ExcFilterBottomSheetState extends State<ExcFilterBottomSheet> {
  late final ExcFilters filters;

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
                      Align(
                        child: Text(
                          context.l10n.filterBy.capitalized,
                          style: context.textThemeX.large.bold,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                          onPressed: context.read<ExercisesBloc>().state.filters.isEmpty
                              ? null
                              : () {
                                  context.read<ExercisesBloc>().add(ExcsFiltered(ExcFilters()));
                                  context.pop();
                                },
                          child: Text(context.l10n.reset.capitalized),
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
                        context.l10n.excercisesFrom.capitalized,
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
                      const Divider(),
                      _Filter(
                        title: context.l10n.muscles.capitalized,
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
                      const Divider(),
                      _Filter(
                        title: context.l10n.type.capitalized,
                        values: ExType.values,
                        initialValues: filters.types,
                        onSelected: (selected, v) {
                          setState(() {
                            if (selected) {
                              filters.types.add(v);
                            } else {
                              filters.types.remove(v);
                            }
                          });
                        },
                      ),
                      const Divider(),
                      _Filter(
                        title: context.l10n.equipment.capitalized,
                        values: Equipment.values,
                        initialValues: filters.equipments,
                        onSelected: (selected, v) {
                          setState(() {
                            if (selected) {
                              filters.equipments.add(v);
                            } else {
                              filters.equipments.remove(v);
                            }
                          });
                        },
                      ),
                      //TODO: make it a slider.
                      const Divider(),
                      _Filter(
                        title: context.l10n.level.capitalized,
                        values: ExLevel.values,
                        initialValues: filters.levels,
                        onSelected: (selected, v) {
                          setState(() {
                            if (selected) {
                              filters.levels.add(v);
                            } else {
                              filters.levels.remove(v);
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
                    if (filters.isEmpty && context.read<ExercisesBloc>().state.filters.isEmpty) {
                      return context.pop();
                    }
                    context.read<ExercisesBloc>().add(ExcsFiltered(filters));
                    context.pop();
                  },
                  label: context.l10n.applyFilter.capitalized,
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
