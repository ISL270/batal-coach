import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercises/presentation/widgets/exercises_picker.dart';
import 'package:btl/app/coach/features/workout_builder.dart/presentation/cubit/workout_builder_cubit.dart';
import 'package:btl/app/core/constants/default.dart';
import 'package:btl/app/core/extensions/duration_x.dart';
import 'package:btl/app/core/extensions/text_style_x.dart';
import 'package:btl/app/core/models/domain/field.dart';
import 'package:btl/app/core/models/domain/length_unit.dart';
import 'package:btl/app/core/models/domain/mass_unit.dart';
import 'package:btl/app/core/models/domain/set.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/number_picker_bs.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

part 'exercises_sets_screen.dart';
part 'workout_details_screen.dart';

class WorkoutBuilderScreen extends StatefulWidget {
  static const name = 'workout_builder';

  const WorkoutBuilderScreen({super.key});

  @override
  State<WorkoutBuilderScreen> createState() => _WorkoutBuilderScreenState();
}

class _WorkoutBuilderScreenState extends State<WorkoutBuilderScreen> {
  late final WorkoutBuilderCubit _cubit;

  @override
  void initState() {
    _cubit = context.read<WorkoutBuilderCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBuilderCubit, WorkoutBuilderState>(
      builder: (context, state) {
        return PageView(
          scrollDirection: Axis.vertical,
          controller: _cubit.pageController,
          children: [
            BlocProvider.value(
              value: _cubit,
              child: const _WkDetails(),
            ),
            BlocProvider.value(
              value: _cubit,
              child: const _ExercisesSetsScreen(),
            )
          ],
        );
      },
    );
  }
}
