import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/core/extensions/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final Exercise exercise;
  const ExerciseTile(this.exercise, {super.key});

  @override
  Widget build(BuildContext context) {
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
        '${context.tr(exercise.mainMuscle.name)} - ${context.tr(exercise.equipment?.name ?? '')} - ${context.tr(exercise.type?.name ?? '')} - ${context.tr(exercise.level?.name ?? '')}',
        style: context.textThemeX.small,
      ),
    );
  }
}
