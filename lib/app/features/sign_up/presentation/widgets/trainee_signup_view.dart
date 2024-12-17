part of '../sign_up_screen.dart';

class _ThirdPageView extends StatefulWidget {
  const _ThirdPageView();

  @override
  State<_ThirdPageView> createState() => ThirdPageView();
}

class ThirdPageView extends State<_ThirdPageView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ArrowBackButton(),
            Gap(25),
            _CoachEmailField(),
            Gap(25),
            _PhoneNumberField(),
            Gap(186),
            _SignUpButton(),
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
          key: const Key('signUpForm_coachEmailInput_textField'),
          initialValue: state.coachEmail.value,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          onChanged: (email) => context.read<SignUpCubit>().coachEmailChanged(email),
          style: TextStyle(color: context.colorsX.background),
          decoration: InputDecoration(
            errorText: state.email.displayError != null ? context.l10n.invalidEmail : null,
            label: Text(
              context.l10n.coachemail.capitalized,
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
