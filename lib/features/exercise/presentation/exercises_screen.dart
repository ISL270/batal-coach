import 'package:btl/core/enums/status.dart';
import 'package:btl/core/extensions/english_x.dart';
import 'package:btl/core/extensions/text_style_x.dart';
import 'package:btl/core/theming/app_colors_extension.dart';
import 'package:btl/core/theming/text_theme_extension.dart';
import 'package:btl/features/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:btl/widgets/screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> with AutomaticKeepAliveClientMixin {
  late final ExerciseBloc _bloc;
  late final TextEditingController _searchCntrlr;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ExerciseBloc>();
    _searchCntrlr = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Screen(
      body: BlocBuilder<ExerciseBloc, ExerciseState>(
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
                      onPressed: () {
                        _searchCntrlr.clear();
                        _bloc.add(const ExercisesInitialized());
                      },
                    )
                ],
                hintText: 'Search exercises',
                onChanged: (searchTerm) => _bloc.add(ExerciseSearched(searchTerm)),
              ),
              Expanded(
                child: switch (state.status) {
                  Status.loading => const Center(child: CircularProgressIndicator()),
                  _ => state.displayedExercises.isEmpty
                      ? const Center(child: Text('No exercises found'))
                      : ListView.separated(
                          itemCount: state.displayedExercises.length,
                          separatorBuilder: (_, __) => const Divider(),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          itemBuilder: (context, i) {
                            final exercise = state.displayedExercises.elementAt(i);
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

  @override
  bool get wantKeepAlive => true;
}
