import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/coach/features/exercises/presentation/widgets/exercises_picker.dart';
import 'package:btl/app/coach/features/workout_builder.dart/presentation/cubit/workout_builder_cubit.dart';
import 'package:btl/app/core/constants/default.dart';
import 'package:btl/app/core/extension_methods/bloc_x.dart';
import 'package:btl/app/core/extension_methods/double_x.dart';
import 'package:btl/app/core/extension_methods/duration_x.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/models/domain/field.dart';
import 'package:btl/app/core/models/domain/length_unit.dart';
import 'package:btl/app/core/models/domain/mass_unit.dart';
import 'package:btl/app/core/models/domain/workout.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/number_picker_bs.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartx/dartx.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

part 'exercises_sets_screen.dart';
part 'workout_details_screen.dart';

class WorkoutBuilderScreen extends StatefulWidget {
  static const name = 'workout_builder';

  const WorkoutBuilderScreen({super.key});

  @override
  State<WorkoutBuilderScreen> createState() => _WorkoutBuilderScreenState();
}

class _WorkoutBuilderScreenState extends State<WorkoutBuilderScreen> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: context.wkBuilderCubit.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        BlocProvider.value(
          value: context.wkBuilderCubit,
          child: const _WkDetails(),
        ),
        BlocProvider.value(
          value: context.wkBuilderCubit,
          child: const _ExercisesSetsScreen(),
        )
      ],
    );
  }
}
