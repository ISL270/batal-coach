import 'package:btl/app/core/extensions/bloc_x.dart';
import 'package:btl/app/core/extensions/context_x.dart';
import 'package:btl/app/core/extensions/english_x.dart';
import 'package:btl/app/core/extensions/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:btl/app/features/settings/settings/settings_bloc.dart';
import 'package:btl/app/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const name = 'signup';

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(context.l10n.signUp.capitalized),
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
            onPressed: context.settingsBloc.switchLanguage,
            icon: const Icon(Icons.g_translate),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocSelector<SignUpCubit, SignUpState, UserType>(
              selector: (state) => state.userType,
              builder: (context, userType) => Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: SegmentedButton(
                      style: SegmentedButton.styleFrom(
                        textStyle: context.textThemeX.small.bold,
                      ),
                      expandedInsets: const EdgeInsets.all(1),
                      showSelectedIcon: false,
                      onSelectionChanged: (selection) =>
                          context.read<SignUpCubit>().changeUserType(selection.first),
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
                  const Gap(20),
                  if (userType.isTrainee) const _CoachEmailField(),
                  if (userType.isTrainee) const Gap(25),
                ],
              ),
            ),
            const _EmailField(),
            const Gap(25),
            const _NameField(),
            const Gap(25),
            const _PhoneNumberField(),
            const Gap(25),
            const _PasswordField(),
            const Gap(25),
            const _ConfirmPasswordField(),
            const Gap(25),
            const _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _CoachEmailField extends StatelessWidget {
  const _CoachEmailField();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.coachEmail != current.coachEmail,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.coachEmail.value,
          key: const Key('signUpForm_coachEmailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().coachEmailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: context.l10n.yourCoachEmail.capitalized,
            errorText: state.email.displayError != null ? context.l10n.invalidEmail : null,
          ),
        );
      },
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: context.l10n.email.capitalized,
            errorText: state.email.displayError != null ? context.l10n.invalidEmail : null,
          ),
        );
      },
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField();
  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, Name>(
      selector: (state) => state.name,
      builder: (context, name) => TextField(
        key: const Key('signUpForm_nameInput_textField'),
        onChanged: (email) => context.read<SignUpCubit>().nameChanged(email),
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          labelText: context.l10n.name.capitalized,
          errorText: name.displayError == null ? null : context.tr(name.displayError!.name),
        ),
      ),
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, PhoneNumber>(
      selector: (state) => state.phoneNumber,
      builder: (context, phoneNumber) => TextField(
        key: const Key('signUpForm_phoneInput_textField'),
        onChanged: (email) => context.read<SignUpCubit>().phoneChanged(email),
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(15),
        ],
        decoration: InputDecoration(
          labelText: context.l10n.phoneNumber.capitalized,
          errorText:
              phoneNumber.displayError == null ? null : context.tr(phoneNumber.displayError!.name),
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) => context.read<SignUpCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: context.l10n.password.capitalized,
            errorText: state.password.displayError != null ? context.l10n.invalidPassword : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordField extends StatelessWidget {
  const _ConfirmPasswordField();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) =>
              context.read<SignUpCubit>().confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            labelText: context.l10n.confirmPassword.capitalized,
            errorText:
                state.confirmPassword.displayError != null ? context.l10n.passwordsDontMatch : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isFailure) {
          context.scaffoldMessenger
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      builder: (context, state) {
        return Button.filled(
          key: const Key('signUpForm_button'),
          maxWidth: true,
          shape: ButtonShape.roundedCorners,
          isLoading: state.status.isLoading,
          density: ButtonDensity.comfortable,
          onPressed: state.isValid ? () => context.read<SignUpCubit>().signUpFormSubmitted() : null,
          label: context.l10n.signUp.capitalized,
        );
      },
    );
  }
}
