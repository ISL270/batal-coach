import 'package:btl/app/coach/features/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:btl/app/coach/features/exercise/presentation/widgets/exercise_tile.dart';
import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/extensions/scroll_controller_x.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> with AutomaticKeepAliveClientMixin {
  late final ExerciseBloc _bloc;
  late final TextEditingController _searchCntrlr;
  late final ScrollController _scrollCntrlr;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Screen(
      body: BlocConsumer<ExerciseBloc, ExerciseState>(
        listener: (context, state) {
          if (state.searchTerm.isBlank) _searchCntrlr.clear();
        },
        builder: (context, state) {
          return Column(
            children: [
              SearchBar(
                controller: _searchCntrlr,
                trailing: [
                  if (state.searchTerm.isNotBlank)
                    IconButton(
                      icon: const Icon(Icons.cancel),
                      color: context.colorsX.onBackgroundTint,
                      onPressed: () => _bloc.add(const ExerciseSearched('')),
                    )
                ],
                hintText: 'Search exercises',
                onChanged: (searchTerm) => _bloc.add(ExerciseSearched(searchTerm)),
              ),
              const Gap(10),
              Expanded(
                child: switch (state.status) {
                  Loading() => const Center(child: CircularProgressIndicator()),
                  _ => state.exercises.result.isEmpty
                      ? const Center(child: Text('No exercises found'))
                      : ListView.separated(
                          controller: _scrollCntrlr,
                          itemCount: state.status.isPageLoading
                              ? state.exercises.result.length + 1
                              : state.exercises.result.length,
                          separatorBuilder: (_, __) => const Divider(),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          itemBuilder: (context, i) {
                            if (i >= state.exercises.result.length) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            return ExerciseTile(state.exercises.result[i]);
                          },
                        ),
                },
              )
            ],
          );
        },
      ),
    );
  }

  void _onScroll() {
    if (_scrollCntrlr.hasReachBottom) _bloc.add(ExerciseNextPageFetched());
  }

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ExerciseBloc>();
    _searchCntrlr = TextEditingController();
    _scrollCntrlr = ScrollController();
    _scrollCntrlr.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollCntrlr
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
