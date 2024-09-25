import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';

class WorkoutBuilderScreen extends StatelessWidget {
  const WorkoutBuilderScreen({super.key});

  static const name = 'workout_builder';

  @override
  Widget build(BuildContext context) {
    return const Screen(
      body: Center(child: Text('Workout builder')),
    );
  }
}
