import 'package:btl/app/core/extension_methods/bloc_x.dart';
import 'package:btl/app/core/extension_methods/english_x.dart';
import 'package:btl/app/core/extension_methods/getit_x.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/injection/injection.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/l10n/language.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:btl/app/features/settings/settings/settings_bloc.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const name = 'settings';

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.l10n.settings.capitalized,
          style: context.textThemeX.large.bold,
        ),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settings) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _AvatarLabelRow(),
                Gap(30.h),
                _SettingsSectionWidget(
                  iconData: FontAwesomeIcons.lock,
                  label: context.l10n.changepassword.capitalized,
                ),
                Gap(30.h),
                _SettingsSectionWidget(
                  iconData: FontAwesomeIcons.bell,
                  label: context.l10n.notifications.capitalized,
                ),
                Gap(30.h),
                _SettingsSectionWidget(
                  // ignore: deprecated_member_use
                  iconData: FontAwesomeIcons.listNumeric,
                  label: context.l10n.units.capitalized,
                ),
                Gap(30.h),
                _SettingsSectionWidget(
                  iconData: FontAwesomeIcons.headset,
                  label: context.l10n.technicalsupport.capitalized,
                ),
                Gap(30.h),
                _SettingsSectionWidget(
                  iconData: FontAwesomeIcons.mobileScreenButton,
                  label: context.l10n.aboutapp.capitalized,
                ),
                const Spacer(),
                Gap(25.h),
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
                          label: Text(context.l10n.light.capitalized),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          label: Text(context.l10n.dark.capitalized),
                        ),
                        ButtonSegment(
                          value: ThemeMode.system,
                          label: Text(context.l10n.system.capitalized),
                        ),
                      ],
                    )
                  ],
                ),
                Gap(25.h),
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
                          label: Text(Language.arabic.name),
                        ),
                        ButtonSegment(
                          value: Language.english,
                          label: Text(Language.english.name),
                        ),
                      ],
                    )
                  ],
                ),
                Gap(25.h),
                Button.outlined(
                  maxWidth: true,
                  density: ButtonDensity.comfortable,
                  onPressed: () => getIt.authBloc.add(AuthLogoutRequested()),
                  label: context.l10n.logout.capitalized,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AvatarLabelRow extends StatelessWidget {
  const _AvatarLabelRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textBaseline: TextBaseline.ideographic,
      children: [
        CircleAvatar(radius: 18.w),
        SizedBox(width: 15.w),
        Text(
          context.l10n.profile.capitalized,
          style: context.textThemeX.medium.copyWith(textBaseline: TextBaseline.ideographic),
        ),
        const Spacer(),
        Icon(Icons.arrow_forward_ios_rounded, size: 18.w)
      ],
    );
  }
}

class _SettingsSectionWidget extends StatelessWidget {
  const _SettingsSectionWidget({
    required this.label,
    required this.iconData,
    // ignore: unused_element
    this.onPressed,
  });

  final String label;
  final void Function()? onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Gap(5.w),
          Icon(iconData),
          Gap(20.w),
          Text(
            label,
            style: context.textThemeX.medium.copyWith(textBaseline: TextBaseline.ideographic),
          ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios_rounded, size: 18.w)
        ],
      ),
    );
  }
}
