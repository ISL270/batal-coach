import 'package:btl/app/core/blocs/auth/auth_bloc.dart';
import 'package:btl/app/core/extensions/bloc_x.dart';
import 'package:btl/app/core/extensions/english_x.dart';
import 'package:btl/app/core/extensions/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/l10n/language.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/features/settings/settings/settings_bloc.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settings) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n.theme.capitalized,
                      style: context.textThemeX.large.bold,
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
                            context.l10n.light.capitalized,
                            style: context.textThemeX.small,
                          ),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          label: Text(
                            context.l10n.dark.capitalized,
                            style: context.textThemeX.small,
                          ),
                        ),
                        ButtonSegment(
                          value: ThemeMode.system,
                          label: Text(
                            context.l10n.system.capitalized,
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
                      context.l10n.language.capitalized,
                      style: context.textThemeX.large.bold,
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
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => context.authBloc.add(AuthLogoutRequested()),
                    label: Text(
                      context.l10n.logout.capitalized,
                      style: context.textThemeX.large.bold,
                    ),
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.exit_to_app),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
