import 'package:btl/app/enum/language.dart';
import 'package:btl/app/extension/bloc_extension.dart';
import 'package:btl/app/extension/text_style.dart';
import 'package:btl/app/theming/text_theme_extension.dart';
import 'package:btl/features/settings/settings/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settings) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Theme',
                      style: context.textThemeX.medium.bold,
                    ),
                    SegmentedButton(
                      showSelectedIcon: false,
                      selected: {settings.themeMode},
                      onSelectionChanged: (selection) {
                        context.settingsBloc.add(SettingsThemeChanged(selection.first));
                      },
                      segments: [
                        ButtonSegment(
                          value: ThemeMode.light,
                          label: Text(
                            'Light',
                            style: context.textThemeX.small,
                          ),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          label: Text(
                            'Dark',
                            style: context.textThemeX.small,
                          ),
                        ),
                        ButtonSegment(
                          value: ThemeMode.system,
                          label: Text(
                            'System',
                            style: context.textThemeX.small,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Language',
                      style: context.textThemeX.medium.bold,
                    ),
                    SegmentedButton(
                      showSelectedIcon: false,
                      selected: {settings.language},
                      onSelectionChanged: (selection) {
                        context.settingsBloc.add(SettingsLanguageChanged(selection.first));
                      },
                      segments: [
                        ButtonSegment(
                          value: Language.arabic,
                          label: Text(
                            Language.arabic.name,
                            style: context.textThemeX.small,
                          ),
                        ),
                        ButtonSegment(
                          value: Language.english,
                          label: Text(
                            Language.english.name,
                            style: context.textThemeX.small,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
