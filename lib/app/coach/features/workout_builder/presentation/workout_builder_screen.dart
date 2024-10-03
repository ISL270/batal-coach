import 'dart:developer';

import 'package:btl/app/coach/features/exercises/domain/models/exercise_category.dart';
import 'package:btl/app/core/extensions/context_x.dart';
import 'package:btl/app/core/extensions/getit_x.dart';
import 'package:btl/app/core/injection/injection.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:btl/app/widgets/selection_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class WorkoutBuilderScreen extends StatelessWidget {
  const WorkoutBuilderScreen({super.key});

  static const name = 'workout_builder';

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            context.pop();
          },
        ),
        title: const Text('New Excercise'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Create'),
          ),
        ],
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        physics: const BouncingScrollPhysics(),
        children: [
          const _NameInput(),
          const Gap(16),
          GestureDetector(
            onTap: () {
              SelectionBottomsheet(
                items: ExCategory.values,
                builder: (val) {
                  return SelectionBottomsheetItem(
                    title: getIt.l10nSvc.trFromStr(val.name, context),
                  );
                },
                onItemSelected: (val) {
                  log(val.toString());
                  context.pop(val);
                },
                onReset: () {
                  // TODO: on reset value
                },
              ).showSelectionBottomsheet(context);
            },
            child: Container(
              color: context.colorsX.background,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: context.theme.textTheme.labelLarge,
                          ),
                          Text(
                            'Selected Value',
                            style: context.theme.textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (name) {},
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Excercise Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // errorText: '',
        border: const UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: context.colorsX.primary),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: context.colorsX.error),
        ),
        disabledBorder: const UnderlineInputBorder(),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: context.colorsX.error),
        ),
      ),
    );
  }
}
