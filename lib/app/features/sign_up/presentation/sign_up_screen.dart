import 'package:btl/app/core/constants/app_colors.dart';
import 'package:btl/app/core/constants/app_validators.dart';
import 'package:btl/app/core/extensions/bloc_x.dart';
import 'package:btl/app/core/extensions/context_x.dart';
import 'package:btl/app/core/extensions/english_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/features/settings/settings/settings_bloc.dart';
import 'package:btl/app/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:btl/app/features/sign_up/presentation/widgets/already_have_an_account.dart';
import 'package:btl/app/features/sign_up/presentation/widgets/custom_icon_elevated_button.dart';
import 'package:btl/app/features/sign_up/presentation/widgets/custom_text_form_field.dart';
import 'package:btl/app/features/sign_up/presentation/widgets/sign_up_shape_container_widget.dart';
import 'package:btl/app/widgets/button.dart';
import 'package:btl/app/widgets/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const name = 'signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? selectedRole;
  bool loading = false;

  late PageController pageController;

  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> formKey2 = GlobalKey();

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

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
                  icon: const Icon(
                    FontAwesomeIcons.arrowLeftLong,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
                const Gap(15),
                Text(
                  context.l10n.createaccount,
                  style: const TextStyle(
                    fontSize: 42,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 280),
            child: Stack(
              children: [
                const SignUpContainerShapeWidget(),
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(74)),
                  child: PageView(controller: pageController, children: [
                    FirstPageView(formKey: formKey, pageController: pageController),
                    SecondPageView(roles: roles, selectedRole: selectedRole ?? '')
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecondPageView extends StatefulWidget {
  const SecondPageView({
    required this.selectedRole,
    required this.roles,
    super.key,
  });

  final String selectedRole;
  final List<String> roles;

  @override
  State<SecondPageView> createState() => _SecondPageViewState();
}

class _SecondPageViewState extends State<SecondPageView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  GlobalKey<FormState> formKey2 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      key: const PageStorageKey('Second_page'),
      child: Padding(
        padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
        child: Form(
          key: formKey2,
          child: Column(
            children: [
              Center(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: customDropDownBorder(context),
                    enabledBorder: customDropDownBorder(context),
                    disabledBorder: customDropDownBorder(context),
                    focusedBorder: customDropDownBorder(context),
                  ),
                  borderRadius: BorderRadius.circular(12),
                  isExpanded: true,
                  value: widget.roles.first,
                  dropdownColor: AppColors.lightTint,
                  hint: Text(
                    context.l10n.selectrole,
                    style: TextStyle(
                      color:
                          context.settingsBloc.state.isThemeDark ? AppColors.dark : AppColors.light,
                    ),
                  ),
                  items: widget.roles.map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(
                        role,
                        style: TextStyle(
                          color: context.settingsBloc.state.isThemeDark
                              ? AppColors.dark
                              : AppColors.light,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    String? selectRole = widget.selectedRole;

                    setState(() {
                      selectRole = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a role';
                    }
                    return null;
                  },
                ),
              ),
              const Gap(25),
              _CompanyField(),
              const Gap(25),
              _PhoneNumberField(),
              const Gap(105),
              _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder customDropDownBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(
      color: context.settingsBloc.state.isThemeDark ? AppColors.onLight : AppColors.onDark,
    ),
  );
}

class FirstPageView extends StatefulWidget {
  const FirstPageView({
    required this.formKey,
    required this.pageController,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final PageController pageController;

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
        child: Form(
          key: widget.formKey,
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
              _NextPageViewButton(pageController: widget.pageController),
              const Gap(20),
              const AlreadyHaveAnAccount(),
              const Gap(20),
            ],
          ),
        ),
      ),
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

class _PhoneNumberField extends StatelessWidget {
  const _PhoneNumberField();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, PhoneNumber>(
      selector: (state) => state.phoneNumber,
      builder: (context, phoneNumber) {
        return CustomTextFormField(
          key: const Key('signUpForm_phoneInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().phoneChanged(email),
          inputFormatter: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(15),
          ],
          keyboardType: TextInputType.phone,
          labelText: context.l10n.phoneNumber.capitalized,
        );
      },
    );
  }
}

class _CompanyField extends StatelessWidget {
  const _CompanyField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      labelText: context.l10n.company,
      onChanged: (p0) {},
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
    return CustomIconElevatedButton(
      text: context.l10n.regcontinue,
      onPressed: () {
        pageController.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeIn,
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
        return CustomTextFormField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          labelText: context.l10n.confirmPassword,
          isPasswordField: true,
          onChanged: (confirmPassword) =>
              context.read<SignUpCubit>().confirmedPasswordChanged(confirmPassword),
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
        return CustomTextFormField(
          key: const Key('signUpForm_passwordInput_textField'),
          textInputAction: TextInputAction.next,
          labelText: context.l10n.password,
          isPasswordField: true,
          onChanged: (password) => context.read<SignUpCubit>().passwordChanged(password),
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
        return CustomTextFormField(
          key: const Key('signUpForm_coachEmailInput_textField'),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          labelText: context.l10n.email,
          onChanged: (email) => context.read<SignUpCubit>().coachEmailChanged(email),
        );
      },
    );
  }
}

class _NameFormField extends StatelessWidget {
  const _NameFormField();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, Name>(
      selector: (state) => state.name,
      builder: (context, state) {
        return CustomTextFormField(
          key: const Key('signUpForm_nameInput_textField'),
          textInputAction: TextInputAction.next,
          labelText: context.l10n.name,
          onChanged: (email) => context.read<SignUpCubit>().nameChanged(email),
        );
      },
    );
  }
}
