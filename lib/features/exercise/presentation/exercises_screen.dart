import 'package:btl/core/extensions/bloc_x.dart';
import 'package:btl/features/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:btl/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          return Column(
            children: [
              SearchBar(
                hintText: 'Search exercises',
                onChanged: (searchTerm) => context.exerciseBloc.add(ExerciseSearched(searchTerm)),
              ),
              switch (state) {
                ExerciseSuccess() => Text(state.searchTerm),
                _ => const SizedBox.shrink(),
              }
            ],
          );
        },
      ),
    );
  }
}
