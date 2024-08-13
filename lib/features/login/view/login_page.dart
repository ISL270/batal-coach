import 'package:authentication_repository/authentication_repository.dart';
import 'package:btl/app/bloc/settings/settings_bloc.dart';
import 'package:btl/app/enum/language.dart';
import 'package:btl/features/login/cubit/login_cubit.dart';
import 'package:btl/features/login/view/login_form.dart';
import 'package:btl/injection/injection.dart';
import 'package:btl/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.login),
        actions: [
          IconButton(
            onPressed: () {
              final lang = context.read<SettingsBloc>().state.language == Language.arabic
                  ? Language.english
                  : Language.arabic;
              context.read<SettingsBloc>().add(SettingsLanguageChanged(lang));
            },
            icon: const Icon(Icons.g_translate),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => LoginCubit(getIt.get<AuthenticationRepository>()),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
