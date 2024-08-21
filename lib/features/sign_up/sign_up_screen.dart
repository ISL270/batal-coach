import 'package:authentication_repository/authentication_repository.dart';
import 'package:btl/core/extensions/bloc_extension.dart';
import 'package:btl/core/injection/injection.dart';
import 'package:btl/features/settings/settings/settings_bloc.dart';
import 'package:btl/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:btl/features/sign_up/widgets/sign_up_form.dart';
import 'package:btl/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const name = 'signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(context.l10n.signUp),
        actions: [
          IconButton(
            onPressed: () {
              context.settingsBloc.add(SettingsThemeChanged(
                context.settingsBloc.state.isThemeDark ? ThemeMode.light : ThemeMode.dark,
              ));
            },
            icon: const Icon(Icons.dark_mode),
          ),
          IconButton(
            onPressed: context.read<SettingsBloc>().switchLanguage,
            icon: const Icon(Icons.g_translate),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(getIt.get<AuthenticationRepository>()),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
