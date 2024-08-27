import 'package:btl/core/enums/status.dart';
import 'package:btl/core/theming/app_colors_extension.dart';
import 'package:btl/features/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:btl/widgets/screen.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
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
                      : ListView.builder(
                          itemCount: state.displayedExercises.length,
                          itemBuilder: (context, i) {
                            return ListTile(
                              title: Text(state.displayedExercises.elementAt(i).name),
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
}
