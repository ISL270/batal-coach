import 'package:btl/app/coach/features/exercise/domain/models/exercise.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final Exercise exercise;
  const ExerciseTile(this.exercise, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/btl-dev-69d91.appspot.com/o/default_exercises%2Fweighted_crunches.gif?alt=media&token=b17224d9-6542-4292-b600-fd9949a7f913',
      ),
      title: Text(exercise.name),
      subtitle: Text(exercise.level ?? 'unkonwn'),
    );
  }
}
