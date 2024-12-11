import 'package:btl/app/coach/features/exercises/presentation/exercises_screen.dart';
import 'package:btl/app/core/extension_methods/context_x.dart';
import 'package:btl/app/core/extension_methods/english_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/features/authentication/domain/models/coach_type.dart';
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

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const name = 'signup';

  @override
  Widget build(BuildContext context) {
    final roles = <String>[
      context.l10n.fitness,
      context.l10n.nutrition,
      context.l10n.manager,
    ];

    return Screen(
      padding: EdgeInsets.zero,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 50,
              left: context.l10n.localeName == 'en' ? 20 : 0,
              right: context.l10n.localeName == 'ar' ? 20 : 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.arrowLeftLong),
                  onPressed: () => context.pop(),
                ),
                const Gap(15),
                Text(
                  context.l10n.createaccount,
                  style: const TextStyle(fontSize: 42),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 280),
            child: Stack(
              children: [
                const _SignUpContainerShapeWidget(),
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(74)),
                  child: PageView(
                    controller: context.read<SignUpCubit>().pageController,
                    children: [
                      const FirstPageView(),
                      SecondPageView(roles: roles),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Sign up Fields.
class FirstPageView extends StatefulWidget {
  const FirstPageView({
    super.key,
  });

  @override
  State<FirstPageView> createState() => _FirstPageViewState();
}

class _FirstPageViewState extends State<FirstPageView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      key: const PageStorageKey('First_page'),
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
        child: Column(
          children: [
            const _NameFormField(),
            const Gap(25),
            const _EmailField(),
            const Gap(25),
            const _PasswordField(),
            const Gap(25),
            const _ConfirmPasswordField(),
            const Gap(25),
            _NextPageViewButton(pageController: context.read<SignUpCubit>().pageController),
            const Gap(20),
            const _AlreadyHaveAnAccount(),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

class SecondPageView extends StatefulWidget {
  const SecondPageView({
    required this.roles,
    super.key,
  });

  final List<String> roles;

  @override
  State<SecondPageView> createState() => _SecondPageViewState();
}

class _SecondPageViewState extends State<SecondPageView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  GlobalKey<FormState> formKey2 = GlobalKey();

  Color? color;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      key: const PageStorageKey('Second_page'),
      child: Padding(
        padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
        child: Column(
          children: [
            BlocSelector<SignUpCubit, SignUpState, CoachType>(
              selector: (state) => state.coachType,
              builder: (context, coachType) {
                return Center(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: context.colorsX.background,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: context.colorsX.background,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: context.colorsX.background,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(
                          color: context.colorsX.background,
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(12),
                    isExpanded: true,
                    iconEnabledColor: context.colorsX.secondaryBackground,
                    value: widget.roles.first,
                    dropdownColor: context.colorsX.secondary,
                    enableFeedback: true,
                    items: widget.roles.map((role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(
                          role,
                          style: TextStyle(
                            color: context.colorsX.background,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // CoachType.values
                      //     .firstWhere((type) => type.name == value!.contains(type.name));
                      setState(() {});
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a role';
                      }
                      return null;
                    },
                  ),
                );
              },
            ),
            const Gap(25),
            const _CompanyField(),
            const Gap(25),
            const _PhoneNumberField(),
            const Gap(105),
            const _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _NameFormField extends StatelessWidget {
  const _NameFormField();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, Name>(
      selector: (state) => state.name,
      builder: (context, name) {
        return TextFormField(
          key: const Key('signUpForm_nameInput_textField'),
          textInputAction: TextInputAction.next,
          onChanged: (email) => context.read<SignUpCubit>().nameChanged(email),
          style: TextStyle(
            color: context.colorsX.background,
          ),
          decoration: InputDecoration(
            label: Text(
              context.l10n.name.capitalized,
              style: context.textThemeX.small.copyWith(
                color: context.colorsX.background,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            errorText: name.displayError == null ? null : context.tr(name.displayError!.name),
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
      buildWhen: (previous, current) => previous.coachEmail != current.coachEmail,
      builder: (context, state) {
        return TextFormField(
          key: const Key('signUpForm_coachEmailInput_textField'),
          initialValue: state.coachEmail.value,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          onChanged: (email) => context.read<SignUpCubit>().coachEmailChanged(email),
          style: TextStyle(
            color: context.colorsX.background,
          ),
          decoration: InputDecoration(
            errorText: state.email.displayError != null ? context.l10n.invalidEmail : null,
            label: Text(
              context.l10n.email.capitalized,
              style: context.textThemeX.small.copyWith(
                color: context.colorsX.background,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
          ),
        );
      },
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
        return TextFormField(
          key: const Key('signUpForm_passwordInput_textField'),
          textInputAction: TextInputAction.next,
          onChanged: (password) => context.read<SignUpCubit>().passwordChanged(password),
          style: TextStyle(
            color: context.colorsX.background,
          ),
          obscureText: true,
          decoration: InputDecoration(
            errorText: state.password.displayError != null ? context.l10n.invalidPassword : null,
            label: Text(
              context.l10n.password.capitalized,
              style: context.textThemeX.small.copyWith(
                color: context.colorsX.background,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
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
        return TextFormField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          obscureText: true,
          style: TextStyle(
            color: context.colorsX.background,
          ),
          decoration: InputDecoration(
            errorText:
                state.confirmPassword.displayError != null ? context.l10n.passwordsDontMatch : null,
            label: Text(
              context.l10n.confirmPassword.capitalized,
              style: context.textThemeX.small.copyWith(
                color: context.colorsX.background,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
          ),
          onChanged: (confirmPassword) =>
              context.read<SignUpCubit>().confirmedPasswordChanged(confirmPassword),
        );
      },
    );
  }
}

class _NextPageViewButton extends StatelessWidget {
  const _NextPageViewButton({
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Button.filled(
        height: 0,
        // iconWithAlignment: IconWithAlignment(
        //   Icon(
        //     FontAwesomeIcons.forward,
        //     size: 18,
        //     color: context.colorsX.onBackground,
        //   ),
        //   alignment: IconAlignment.end,
        // ),
        label: context.l10n.regcontinue,
        onPressed: () {
          pageController.nextPage(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeIn,
          );
        },
      ),
    );
  }
}

class _CompanyField extends StatelessWidget {
  const _CompanyField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: context.colorsX.background,
      ),
      decoration: InputDecoration(
        label: Text(
          context.l10n.company.capitalized,
          style: context.textThemeX.small.copyWith(
            color: context.colorsX.background,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: context.colorsX.background,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: context.colorsX.background,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: context.colorsX.background,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: context.colorsX.background,
          ),
        ),
      ),
      onChanged: (p0) {},
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
          onChanged: (email) => context.read<SignUpCubit>().phoneChanged(email),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(15),
          ],
          keyboardType: TextInputType.phone,
          style: TextStyle(
            color: context.colorsX.background,
          ),
          decoration: InputDecoration(
            label: Text(
              context.l10n.phoneNumber.capitalized,
              style: context.textThemeX.small.copyWith(
                color: context.colorsX.background,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: context.colorsX.background,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Widgets
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
        return SizedBox(
          width: double.infinity,
          height: 48,
          child: Button.filled(
            key: const Key('signUpForm_button'),
            maxWidth: true,
            shape: ButtonShape.roundedCorners,
            isLoading: state.status.isLoading,
            density: ButtonDensity.comfortable,
            // onPressed: () => context.read<SignUpCubit>().signUpFormSubmitted(),
            onPressed:
                state.isValid ? () => context.read<SignUpCubit>().signUpFormSubmitted() : null,
            label: context.l10n.signUp.capitalized,
            height: 0,
          ),
        );
      },
    );
  }
}

class _AlreadyHaveAnAccount extends StatelessWidget {
  const _AlreadyHaveAnAccount();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.l10n.alreadyhaveaccount,
          style: TextStyle(
            color: context.colorsX.background,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Text(
            context.l10n.signin,
            style: TextStyle(
              color: context.colorsX.primary,
            ),
          ),
        ),
      ],
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
        color: context.colorsX.onBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(74),
        ),
      ),
    );
  }
}
