// ignore_for_file: unused_field

import 'package:btl/app/coach/features/workout_builder.dart/presentation/workout_builder_screen.dart';
import 'package:btl/app/coach/features/workouts/presentation/bloc/workouts_bloc.dart';
import 'package:btl/app/core/extension_methods/english_x.dart';
import 'package:btl/app/core/extension_methods/string_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/models/status.dart';
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
  late final ScrollController _scrollCntrlr;
  late final TextEditingController _searchCntrlr;
  final isCollapsed = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _scrollCntrlr = ScrollController();
    _bloc = context.read<WorkoutsBloc>();
    _searchCntrlr = TextEditingController();
    _searchCntrlr.addListener(
      () {
        if (_searchCntrlr.text.isEmpty) {
          _bloc.add(const WkSearched(''));
        }
      },
    );
    _scrollCntrlr.addListener(
      () {
        if (_bloc.state.status.isSuccess && _bloc.state.workouts.result.length > 5) {
          return;
        }
        _scrollCntrlr.jumpTo(0);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SuperScaffold(
      scrollController: _scrollCntrlr,
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
          onChanged: (searchTerm) => _bloc.add(WkSearched(searchTerm)),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >= (notification.metrics.maxScrollExtent * .7)) {
            _bloc.add(WkNextPageFetched());
          }
          return true;
        },
        child: BlocBuilder<WorkoutsBloc, WorkoutsState>(
          builder: (context, state) => switch (state.status) {
            Loading() => const Center(child: CircularProgressIndicator()),
            _ => state.workouts.result.isEmpty
                ? const Center(child: Text('No workouts found'))
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.workouts.result.length,
                    separatorBuilder: (_, __) => const Divider(),
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 17),
                    itemBuilder: (context, i) => ListTile(
                      title: Text(state.workouts.result[i].name),
                    ),
                  ),
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollCntrlr.dispose();
    _searchCntrlr.dispose();
    super.dispose();
  }
}
