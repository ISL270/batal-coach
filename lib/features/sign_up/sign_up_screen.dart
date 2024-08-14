import 'package:authentication_repository/authentication_repository.dart';
import 'package:btl/app/bloc/settings/settings_bloc.dart';
import 'package:btl/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:btl/features/sign_up/widgets/sign_up_form.dart';
import 'package:btl/injection/injection.dart';
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
            onPressed: context.read<SettingsBloc>().switchLanguage,
            icon: const Icon(Icons.g_translate),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(getIt.get<AuthenticationRepository>()),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
