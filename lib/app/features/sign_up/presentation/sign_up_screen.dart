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

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController companyController;
  late TextEditingController phoneNumberController;

  late PageController pageController;

  late FocusNode nameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode confirmPasswordFocusNode;

  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> formKey2 = GlobalKey();

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    companyController = TextEditingController();
    phoneNumberController = TextEditingController();

    pageController = PageController();

    nameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    companyController.dispose();
    phoneNumberController.dispose();

    pageController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
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
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              CustomTextFormField(
                                textEditingController: nameController,
                                focusNode: nameFocusNode,
                                validator: AppValidators.displayNamevalidator,
                                textInputAction: TextInputAction.next,
                                labelText: context.l10n.name,
                                onChanged: (v) {
                                  nameController.text = v!;
                                  setState(() {});
                                },
                              ),
                              const Gap(25),
                              CustomTextFormField(
                                textEditingController: emailController,
                                focusNode: emailFocusNode,
                                validator: AppValidators.emailValidator,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                labelText: context.l10n.email,
                                onChanged: (v) {
                                  emailController.text = v!;
                                  setState(() {});
                                },
                              ),
                              const Gap(25),
                              CustomTextFormField(
                                textEditingController: passwordController,
                                focusNode: passwordFocusNode,
                                validator: AppValidators.passwordValidator,
                                textInputAction: TextInputAction.next,
                                labelText: context.l10n.password,
                                onChanged: (v) {
                                  passwordController.text = v!;
                                  setState(() {});
                                },
                              ),
                              const Gap(25),
                              CustomTextFormField(
                                textEditingController: confirmPasswordController,
                                focusNode: confirmPasswordFocusNode,
                                validator: (v) {
                                  return AppValidators.repeatPasswordValidator(
                                    password: passwordController.text,
                                    value: v,
                                  );
                                },
                                labelText: context.l10n.confirmPassword,
                                onChanged: (v) {
                                  confirmPasswordController.text = v!;
                                  setState(() {});
                                },
                              ),
                              const Gap(25),
                              CustomIconElevatedButton(
                                text: context.l10n.regcontinue,
                                infoFilled: infoFill(),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    pageController.nextPage(
                                      duration: const Duration(milliseconds: 600),
                                      curve: Curves.easeIn,
                                    );
                                  }
                                },
                              ),
                              const Gap(20),
                              const AlreadyHaveAnAccount(),
                              const Gap(20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
                        child: Form(
                          key: formKey2,
                          child: Column(
                            children: [
                              Center(
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    border: CustomDropDownBorder(context),
                                    enabledBorder: CustomDropDownBorder(context),
                                    disabledBorder: CustomDropDownBorder(context),
                                    focusedBorder: CustomDropDownBorder(context),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  isExpanded: true,
                                  value: selectedRole,
                                  dropdownColor: AppColors.lightTint,
                                  hint: Text(
                                    context.l10n.selectrole,
                                    style: TextStyle(
                                      color: context.settingsBloc.state.isThemeDark
                                          ? AppColors.dark
                                          : AppColors.light,
                                    ),
                                  ),
                                  items: roles.map((role) {
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
                                    setState(() {
                                      selectedRole = value;
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
                              CustomTextFormField(
                                labelText: context.l10n.company,
                                focusNode: FocusNode(),
                                onChanged: (p0) {},
                                textEditingController: companyController,
                                validator: (v) {
                                  return null;
                                },
                              ),
                              const Gap(25),
                              CustomTextFormField(
                                labelText: context.l10n.phoneNumber,
                                focusNode: FocusNode(),
                                onChanged: (p0) {},
                                textEditingController: phoneNumberController,
                                validator: AppValidators.phoneNumber,
                                keyboardType: TextInputType.number,
                              ),
                              const Gap(105),
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: Button.filled(
                                  onPressed: () {
                                    if (formKey2.currentState!.validate()) {}
                                  },
                                  label: context.l10n.createAccount.capitalized,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool infoFill() {
    if (nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  OutlineInputBorder CustomDropDownBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(
        color: context.settingsBloc.state.isThemeDark ? AppColors.onLight : AppColors.onDark,
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
