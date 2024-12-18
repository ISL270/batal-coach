import 'package:btl/app/core/extension_methods/bloc_x.dart';
import 'package:btl/app/core/extension_methods/context_x.dart';
import 'package:btl/app/core/extension_methods/english_x.dart';
import 'package:btl/app/core/extension_methods/text_style_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/l10n/language.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/features/authentication/domain/models/coach_type.dart';
import 'package:btl/app/features/authentication/domain/models/user_type.dart';
import 'package:btl/app/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

part 'widgets/initial_signup_view.dart';
part 'widgets/coach_signup_view.dart';
part 'widgets/trainee_signup_view.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const name = 'signup';

  @override
  Widget build(BuildContext context) {
    return Screen(
      padding: EdgeInsets.zero,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 50,
              left: context.settingsBloc.state.language.isEnglish ? 20 : 0,
              right: context.settingsBloc.state.language.isArabic ? 20 : 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.arrowLeftLong),
                  onPressed: () => context.pop(),
                ),
                const Gap(15),
                Text(context.l10n.createaccount, style: const TextStyle(fontSize: 42)),
              ],
            ),
          ),
          BlocSelector<SignUpCubit, SignUpState, UserType>(
            selector: (state) => state.userType,
            builder: (context, userType) {
              return Padding(
                padding: const EdgeInsets.only(top: 280),
                child: Stack(
                  children: [
                    const _SignUpContainerShapeWidget(),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(74)),
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: context.read<SignUpCubit>().pageController,
                        children: [
                          const _InitialPageView(),
                          if (userType.isCoach) const _CoachPageView(),
                          if (userType.isTrainee) const _TraineePageView(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SignUpContainerShapeWidget extends StatelessWidget {
  const _SignUpContainerShapeWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colorsX.onBackgroundTint,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(74)),
      ),
    );
  }
}

class _ArrowBackButton extends StatelessWidget {
  const _ArrowBackButton();

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      icon: const Icon(FontAwesomeIcons.arrowLeft),
      color: context.colorsX.background,
      style: IconButton.styleFrom(side: BorderSide(color: context.colorsX.background)),
      onPressed: () => context
          .read<SignUpCubit>()
          .pageController
          .previousPage(duration: const Duration(milliseconds: 600), curve: Curves.decelerate),
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
          height: 40,
        );
      },
    );
  }
}

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, PhoneNumber>(
      selector: (state) => state.phoneNumber,
      builder: (context, phoneNumber) {
        return TextFormField(
          key: const Key('signUpForm_phoneInput_textField'),
          onChanged: (phoneNumber) => context.read<SignUpCubit>().phoneChanged(phoneNumber),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(15),
          ],
          keyboardType: TextInputType.phone,
          style: TextStyle(color: context.colorsX.background),
          decoration: InputDecoration(
            label: Text(
              context.l10n.phoneNumber.capitalized,
              style: context.textThemeX.small.copyWith(color: context.colorsX.background),
            ),
            border: _signUpOutLinedInputBorder(context),
            enabledBorder: _signUpOutLinedInputBorder(context),
            focusedBorder: _signUpOutLinedInputBorder(context),
            disabledBorder: _signUpOutLinedInputBorder(context),
          ),
        );
      },
    );
  }
}

// just for the sign up screen
OutlineInputBorder _signUpOutLinedInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: context.colorsX.background),
  );
}
