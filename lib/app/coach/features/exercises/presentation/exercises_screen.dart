import 'package:btl/app/coach/features/exercise_builder/presentation/exercise_builder.dart';
import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercises/presentation/bloc/exercises_bloc.dart';
import 'package:btl/app/coach/features/exercises/presentation/models/exercise_filters.dart';
import 'package:btl/app/coach/features/exercises/presentation/widgets/exercise_tile.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/extensions/english_x.dart';
import 'package:btl/app/core/extensions/string_x.dart';
import 'package:btl/app/core/extensions/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:super_cupertino_navigation_bar/super_cupertino_navigation_bar.dart';

part 'package:btl/app/coach/features/exercises/presentation/widgets/filter_bottomsheet.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  static const name = 'exercises';

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  late final ExercisesBloc _bloc;
  late final ScrollController _scrollCntrlr;
  late final TextEditingController _searchCntrlr;
  final isCollapsed = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _scrollCntrlr = ScrollController();
    _bloc = context.read<ExercisesBloc>();
    _searchCntrlr = TextEditingController();
    _searchCntrlr.addListener(
      () {
        if (_searchCntrlr.text.isEmpty) {
          _bloc.add(const ExcsSearched(''));
        }
      },
    );
    _scrollCntrlr.addListener(
      () {
        if (_bloc.state.status.isSuccess && _bloc.state.exercises.result.length > 5) {
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
        backgroundColor: context.colorsX.background.withOpacity(0.85),
        largeTitle: SuperLargeTitle(largeTitle: context.l10n.exercise(0).capitalizedDefinite),
        actions: ValueListenableBuilder(
          valueListenable: isCollapsed,
          builder: (context, isCollapsed, child) {
            if (isCollapsed) {
              return IconButton(
                iconSize: 28,
                color: context.colorsX.primary,
                icon: const Icon(Icons.add_circle),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                onPressed: () => context.goNamed(ExerciseBuilderScreen.name),
              );
            }
            return TextButton.icon(
              label: Text(context.l10n.create.capitalized),
              icon: const Icon(size: 23, Icons.add_circle),
              onPressed: () => context.goNamed(ExerciseBuilderScreen.name),
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
          onChanged: (searchTerm) => _bloc.add(ExcsSearched(searchTerm)),
          actions: [
            SuperAction(
              behavior: SuperActionBehavior.alwaysVisible,
              child: IconButton(
                iconSize: 30,
                icon: const Icon(Icons.tune),
                color: context.colorsX.primary,
                padding: const EdgeInsetsDirectional.only(start: 20, end: 5),
                onPressed: () => showModalBottomSheet<void>(
                  context: context,
                  // This value must be true in order to show the BottomSheet above the BottomNavBar
                  useRootNavigator: true,
                  scrollControlDisabledMaxHeightRatio: 0.75,
                  builder: (context) => BlocProvider.value(
                    value: _bloc,
                    child: const ExcFilterBottomSheet(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: BlocBuilder<ExercisesBloc, ExercisesState>(
        builder: (context, state) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels >= (notification.metrics.maxScrollExtent * .7)) {
                _bloc.add(ExcsNextPageFetched());
              }
              return true;
            },
            child: switch (state.status) {
              Loading() => const Center(child: CircularProgressIndicator()),
              _ => state.exercises.result.isEmpty
                  ? const Center(child: Text('No exercises found'))
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.exercises.result.length,
                      separatorBuilder: (_, __) => const Divider(),
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 17),
                      itemBuilder: (context, i) => ExerciseTile(state.exercises.result[i]),
                    ),
            },
          );
        },
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
