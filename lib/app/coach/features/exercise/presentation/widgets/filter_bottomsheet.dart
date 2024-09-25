import 'dart:math';

import 'package:btl/app/app.dart';
import 'package:btl/app/coach/features/exercise/domain/models/equipment.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise_category.dart';
import 'package:btl/app/coach/features/exercise/domain/models/exercise_level.dart';
import 'package:btl/app/coach/features/exercise/domain/models/muscle.dart';
import 'package:btl/app/core/extensions/getit_x.dart';
import 'package:btl/app/core/injection/injection.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/widgets/custom_chip.dart';
import 'package:btl/app/widgets/custom_divider.dart';
import 'package:btl/app/widgets/radio_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

// TODO: BottomSheet should be draggable
class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  static Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet<T>(
      // This value must be true in order to show the BottomSheet above the BottomNavBar
      useRootNavigator: true,
      // The Sheet has a back button and reset button so I think it's better to be inDismissible
      isDismissible: false,
      scrollControlDisabledMaxHeightRatio: 0.85,
      context: context,
      builder: (context) {
        return const FilterBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  icon: const Icon(Icons.keyboard_arrow_down),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Reset'),
                )
              ],
            ),
            Center(
              child: Text(
                'Filter by',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const Gap(24),
            const _SectionTitle(title: 'Excercises From'),
            RadioTile(
              value: 'groupValue',
              groupValue: 'groupValue',
              title: 'BTL',
              onChanged: (val) {},
              nullable: true,
            ),
            RadioTile(
              value: 'value',
              groupValue: 'groupValue',
              title: 'Custom Excercises',
              onChanged: (val) {},
              nullable: true,
            ),
            const CustomDivider(),
            const _SectionTitle(title: 'Muscles'),
            const _Muscles(),
            const CustomDivider(),
            const _SectionTitle(title: 'Equipment'),
            const _Equipments(),
            const CustomDivider(),
            const _SectionTitle(title: 'Categories'),
            const _Categories(),
            const CustomDivider(),
            const _SectionTitle(title: 'Level'),
            const _Levels(),
            const Gap(120),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.only(
              bottom: 40,
              top: 20,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white.withOpacity(0), Colors.white.withOpacity(0.9)],
              ),
            ),
            child: UnconstrainedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorsX.primary,
                  foregroundColor: context.colorsX.onPrimary,
                  maximumSize: const Size(160, 50),
                  minimumSize: const Size(150, 50),
                ),
                onPressed: () {},
                child: const Text('Apply Filter'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Levels extends StatelessWidget {
  const _Levels();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 4,
      spacing: 4,
      children: ExLevel.values
          .map(
            (level) => CustomChip(
              title: getIt.l10nSvc.trFromEnum(level, context),
              isSelected: level == ExLevel.expert,
              onTap: (val) {},
            ),
          )
          .toList(),
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 4,
      spacing: 4,
      children: ExCategory.values
          .map(
            (category) => CustomChip(
              title: getIt.l10nSvc.trFromEnum(category, context),
              isSelected: category == ExCategory.cardio,
              onTap: (val) {},
            ),
          )
          .toList(),
    );
  }
}

class _Equipments extends StatelessWidget {
  const _Equipments();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 4,
      spacing: 4,
      children: Equipment.values
          .map(
            (equipment) => CustomChip(
              title: getIt.l10nSvc.trFromEnum(equipment, context),
              isSelected: equipment == Equipment.bands,
              onTap: (val) {},
            ),
          )
          .toList(),
    );
  }
}

class _Muscles extends StatelessWidget {
  const _Muscles();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 4,
      spacing: 4,
      children: Muscle.values
          .map(
            (muscle) => CustomChip(
              title: getIt.l10nSvc.trFromEnum(muscle, context),
              isSelected: muscle == Muscle.abdominals,
              onTap: (val) {},
            ),
          )
          .toList(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap(8),
      ],
    );
  }
}
