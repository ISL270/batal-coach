import 'package:btl/app/core/extensions/english_x.dart';
import 'package:btl/app/core/extensions/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:btl/app/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? context.l10n.signUpFailed)));
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocSelector<SignUpCubit, SignUpState, UserType>(
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
            ),
            const Gap(30),
            _EmailInput(),
            const Gap(8),
            _PasswordInput(),
            const Gap(8),
            _ConfirmPasswordInput(),
            const Gap(8),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) => context.read<SignUpCubit>().passwordChanged(password),
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

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) =>
              context.read<SignUpCubit>().confirmedPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            labelText: context.l10n.confirmPassword.capitalized,
            helperText: '',
            errorText: state.confirmedPassword.displayError != null
                ? context.l10n.passwordsDontMatch
                : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed:
                    state.isValid ? () => context.read<SignUpCubit>().signUpFormSubmitted() : null,
                child: Text(context.l10n.signUp.capitalized),
              );
      },
    );
  }
}
