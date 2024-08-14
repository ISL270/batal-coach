import 'package:authentication_repository/authentication_repository.dart';
import 'package:btl/app/bloc/settings/settings_bloc.dart';
import 'package:btl/features/login/cubit/login_cubit.dart';
import 'package:btl/features/login/widgets/login_form.dart';
import 'package:btl/injection/injection.dart';
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
        title: Text(context.l10n.login),
        actions: [
          IconButton(
            onPressed: context.read<SettingsBloc>().switchLanguage,
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
