// ignore_for_file: unused_field

import 'package:btl/app/coach/features/workout_builder.dart/presentation/workout_builder.dart';
import 'package:btl/app/coach/features/workouts/presentation/bloc/workouts_bloc.dart';
import 'package:btl/app/core/extensions/english_x.dart';
import 'package:btl/app/core/extensions/string_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

class WorkoutsScreen extends StatefulWidget {
  static const name = 'workouts';

  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  late final WorkoutsBloc _bloc;
  late final TextEditingController _searchCntrlr;
  final isCollapsed = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _bloc = context.read<WorkoutsBloc>();
    _searchCntrlr = TextEditingController();
    _searchCntrlr.addListener(
      () {
        if (_searchCntrlr.text.isEmpty) {
          // _bloc.add(const ExSearched(''));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      onCollapsed: (value) => isCollapsed.value = value,
      appBar: SuperAppBar(
        title: Text(context.l10n.workout(0).capitalizedDefinite),
        backgroundColor: context.colorsX.background.withOpacity(0.85),
        largeTitle: SuperLargeTitle(largeTitle: context.l10n.workout(0).capitalizedDefinite),
        actions: ValueListenableBuilder(
          valueListenable: isCollapsed,
          builder: (context, isCollapsed, child) {
            if (isCollapsed) {
              return IconButton(
                iconSize: 28,
                color: context.colorsX.primary,
                icon: const Icon(Icons.add_circle),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                onPressed: () => context.goNamed(WorkoutBuilderScreen.name),
              );
            }
            return TextButton.icon(
              label: Text(context.l10n.create.capitalized),
              icon: const Icon(size: 23, Icons.add_circle),
              onPressed: () => context.goNamed(WorkoutBuilderScreen.name),
            );
          },
        ),
        searchBar: SuperSearchBar(
          height: 45,
          searchController: _searchCntrlr,
          placeholderText: context.l10n.search,
          scrollBehavior: SearchBarScrollBehavior.pinned,
          cancelButtonText: context.l10n.cancel.capitalized,
          resultBehavior: SearchBarResultBehavior.neverVisible,
          cancelTextStyle: TextStyle(color: context.colorsX.primary),
          // onChanged: (searchTerm) => _bloc.add(ExSearched(searchTerm)),
          actions: [
            SuperAction(
              behavior: SuperActionBehavior.alwaysVisible,
              child: IconButton(
                iconSize: 30,
                icon: const Icon(Icons.tune),
                color: context.colorsX.primary,
                padding: const EdgeInsetsDirectional.only(start: 20, end: 5),
                onPressed: () {},
                // onPressed: () => showModalBottomSheet<void>(
                //   context: context,
                //   // This value must be true in order to show the BottomSheet above the BottomNavBar
                //   useRootNavigator: true,
                //   scrollControlDisabledMaxHeightRatio: 0.75,
                //   builder: (context) => BlocProvider.value(
                //     value: _bloc,
                //     child: const _FilterBottomSheet(),
                //   ),
                // ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
