import 'package:btl/app/core/enums/status.dart';
import 'package:btl/app/core/extensions/english_x.dart';
import 'package:btl/app/core/extensions/scroll_controller_x.dart';
import 'package:btl/app/core/extensions/text_style_x.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/trainee/features/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                      onPressed: () => _bloc.add(ExercisesInitialized()),
                    )
                ],
                hintText: 'Search exercises',
                onChanged: (searchTerm) => _bloc.add(ExerciseSearched(searchTerm)),
              ),
              const Gap(10),
              Expanded(
                child: switch (state.status) {
                  Status.loading => const Center(child: CircularProgressIndicator()),
                  _ => state.displayedExercises.isEmpty
                      ? const Center(child: Text('No exercises found'))
                      : ListView.separated(
                          physics: const ClampingScrollPhysics(),
                          controller: _scrollCntrlr,
                          itemCount: state.hasReachedMax
                              ? state.displayedExercises.length
                              : state.displayedExercises.length + 1,
                          separatorBuilder: (_, __) => const Divider(),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          itemBuilder: (context, i) {
                            if (i >= state.displayedExercises.length) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            final exercise = state.displayedExercises[i];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  width: 57,
                                  imageUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/btl-dev-69d91.appspot.com/o/default_exercises%2Fweighted_crunches.gif?alt=media&token=b17224d9-6542-4292-b600-fd9949a7f913',
                                ),
                              ),
                              title: Text(
                                exercise.name,
                                style: context.textThemeX.medium.bold,
                              ),
                              subtitle: Text(
                                '${exercise.level.isNotNullOrBlank ? '${exercise.level!.capitalized} - ' : ''}${exercise.primaryMuscles.first.capitalized}',
                                style: context.textThemeX.small,
                              ),
                            );
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
