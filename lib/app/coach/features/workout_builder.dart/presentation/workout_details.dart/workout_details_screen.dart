import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  static const name = 'workout_details';

  const WorkoutDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('New Workout'),
      ),
      body: const Column(
        children: [
          Gap(30),
          TextField(
            decoration: InputDecoration(labelText: 'Name'),
          ),
          Gap(30),
          TextField(
            maxLines: 5,
            decoration: InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      floatingActionButton: Button.filled(
        onPressed: () {},
        label: 'Add Exercises',
        density: ButtonDensity.comfortable,
      ),
    );
  }
}
