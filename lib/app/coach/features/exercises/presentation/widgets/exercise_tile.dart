import 'package:btl/app/coach/features/exercises/domain/models/exercise.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
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
          imageUrl: exercise.mockImage,
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
