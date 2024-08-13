import 'package:authentication_repository/authentication_repository.dart';
import 'package:btl/app/bloc/settings/settings_bloc.dart';
import 'package:btl/app/enum/language.dart';
import 'package:btl/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:btl/features/sign_up/widgets/sign_up_form.dart';
import 'package:btl/injection/injection.dart';
import 'package:btl/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(context.l10n.signUp),
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
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(getIt.get<AuthenticationRepository>()),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
