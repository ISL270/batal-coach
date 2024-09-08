import 'package:btl/app/core/extensions/bloc_x.dart';
import 'package:btl/app/core/extensions/english_x.dart';
import 'package:btl/app/core/extensions/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:btl/app/features/login/cubit/login_cubit.dart';
import 'package:btl/app/features/settings/settings/settings_bloc.dart';
import 'package:btl/app/features/sign_up/presentation/sign_up_screen.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const name = 'login';

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: Text(
          context.l10n.login.capitalized,
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
            onPressed: context.settingsBloc.switchLanguage,
            icon: const Icon(Icons.g_translate),
          ),
        ],
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                  SnackBar(content: Text(state.errorMessage ?? context.l10n.loginFailed)));
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(40),
              BlocSelector<LoginCubit, LoginState, UserType>(
                selector: (state) => state.userType,
                builder: (context, userType) => SizedBox(
                  width: double.infinity,
                  child: SegmentedButton(
                    style: SegmentedButton.styleFrom(
                      textStyle: context.textThemeX.small.bold,
                    ),
                    expandedInsets: const EdgeInsets.all(1),
                    showSelectedIcon: false,
                    onSelectionChanged: (selection) =>
                        context.read<LoginCubit>().changeUserType(selection.first),
                    segments: [
                      ButtonSegment(
                        value: UserType.coach,
                        label: Text(context.l10n.coach.capitalized),
                      ),
                      ButtonSegment(
                        value: UserType.trainee,
                        label: Text(context.l10n.trainee.capitalized),
                      ),
                    ],
                    selected: {userType},
                  ),
                ),
              ),
              const Gap(30),
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
            labelText: context.l10n.email.capitalized,
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
            labelText: context.l10n.password.capitalized,
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
                child: Text(context.l10n.login.capitalized),
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
        context.l10n.signInWithGoogle.capitalized,
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
        context.l10n.createAccount.capitalized,
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}
