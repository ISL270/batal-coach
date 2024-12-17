part of '../sign_up_screen.dart';

class _FirstPageView extends StatefulWidget {
  const _FirstPageView();

  @override
  State<_FirstPageView> createState() => _FirstPageViewState();
}

class _FirstPageViewState extends State<_FirstPageView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
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
            BlocSelector<SignUpCubit, SignUpState, UserType>(
              selector: (state) => state.userType,
              builder: (context, userType) {
                return SegmentedButton(
                  style: SegmentedButton.styleFrom(textStyle: context.textThemeX.small.bold),
                  expandedInsets: const EdgeInsets.all(1),
                  showSelectedIcon: false,
                  onSelectionChanged: (selection) =>
                      context.read<SignUpCubit>().changeUserType(selection.first),
                  segments: [
                    ButtonSegment(
                      value: UserType.coach,
                      label: Text(
                        context.l10n.coach.capitalized,
                        style: context.textThemeX.small.bold.copyWith(
                          color: userType.isCoach
                              ? context.colorsX.onBackground
                              : context.colorsX.background,
                        ),
                      ),
                    ),
                    ButtonSegment(
                      value: UserType.trainee,
                      label: Text(
                        context.l10n.trainee.capitalized,
                        style: context.textThemeX.small.bold.copyWith(
                          color: userType.isTrainee
                              ? context.colorsX.onBackground
                              : context.colorsX.background,
                        ),
                      ),
                    ),
                  ],
                  selected: {userType},
                );
              },
            ),
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
          style: TextStyle(color: context.colorsX.background),
          decoration: InputDecoration(
            label: Text(
              context.l10n.name.capitalized,
              style: context.textThemeX.small.copyWith(color: context.colorsX.background),
            ),
            errorText: name.displayError == null ? null : context.tr(name.displayError!.name),
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

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          key: const Key('signUpForm_emailInput_textField'),
          initialValue: state.email.value,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          style: TextStyle(color: context.colorsX.background),
          decoration: InputDecoration(
            errorText: state.email.displayError != null ? context.l10n.invalidEmail : null,
            label: Text(
              context.l10n.email.capitalized,
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
          style: TextStyle(color: context.colorsX.background),
          obscureText: true,
          decoration: InputDecoration(
            errorText: state.password.displayError != null ? context.l10n.invalidPassword : null,
            label: Text(
              context.l10n.password.capitalized,
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
          style: TextStyle(color: context.colorsX.background),
          decoration: InputDecoration(
            errorText:
                state.confirmPassword.displayError != null ? context.l10n.passwordsDontMatch : null,
            label: Text(
              context.l10n.confirmPassword.capitalized,
              style: context.textThemeX.small.copyWith(color: context.colorsX.background),
            ),
            border: _signUpOutLinedInputBorder(context),
            enabledBorder: _signUpOutLinedInputBorder(context),
            focusedBorder: _signUpOutLinedInputBorder(context),
            disabledBorder: _signUpOutLinedInputBorder(context),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 48,
          child: Button.filled(
            height: 0,
            label: context.l10n.regcontinue,
            onPressed: context.read<SignUpCubit>().mainInfoValid()
                ? () => pageController.nextPage(
                    duration: const Duration(milliseconds: 600), curve: Curves.decelerate)
                : null,
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
        Text(context.l10n.alreadyhaveaccount, style: TextStyle(color: context.colorsX.background)),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => context.pop(),
          child: Text(context.l10n.signin, style: TextStyle(color: context.colorsX.primary)),
        ),
      ],
    );
  }
}
