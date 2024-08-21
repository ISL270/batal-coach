import 'package:btl/core/l10n/l10n.dart';
import 'package:btl/core/theming/app_colors_extension.dart';
import 'package:btl/features/login/cubit/login_cubit.dart';
import 'package:btl/features/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage ?? context.l10n.loginFailed)));
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(40),
            _EmailInput(),
            const Gap(15),
            _PasswordInput(),
            const Gap(15),
            _LoginButton(),
            const Gap(25),
            _GoogleLoginButton(),
            const Gap(15),
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: context.l10n.email,
            helperText: '',
            errorText: state.email.displayError != null ? context.l10n.invalidEmail : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) => context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: context.l10n.password,
            helperText: '',
            errorText: state.password.displayError != null ? context.l10n.invalidPassword : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed:
                    state.isValid ? () => context.read<LoginCubit>().logInWithCredentials() : null,
                child: Text(context.l10n.login),
              );
      },
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text(
        context.l10n.signInWithGoogle,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(backgroundColor: context.colorsX.secondary),
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: () => context.pushNamed(SignUpScreen.name),
      child: Text(
        context.l10n.createAccount,
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}
