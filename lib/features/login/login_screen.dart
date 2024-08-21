import 'package:authentication_repository/authentication_repository.dart';
import 'package:btl/core/extensions/bloc_extension.dart';
import 'package:btl/core/extensions/text_style.dart';
import 'package:btl/core/injection/injection.dart';
import 'package:btl/core/theming/text_theme_extension.dart';
import 'package:btl/features/login/cubit/login_cubit.dart';
import 'package:btl/features/login/widgets/login_form.dart';
import 'package:btl/features/settings/settings/settings_bloc.dart';
import 'package:btl/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const name = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.login,
          style: context.textThemeX.heading.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.settingsBloc.add(SettingsThemeChanged(
                context.settingsBloc.state.isThemeDark ? ThemeMode.light : ThemeMode.dark,
              ));
            },
            icon: Icon(
              context.settingsBloc.state.isThemeDark ? Icons.dark_mode : Icons.dark_mode_outlined,
            ),
          ),
          IconButton(
            onPressed: context.read<SettingsBloc>().switchLanguage,
            icon: const Icon(Icons.g_translate),
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) => LoginCubit(getIt.get<AuthenticationRepository>()),
        child: const LoginForm(),
      ),
    );
  }
}
