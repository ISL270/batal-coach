part of '../sign_up_screen.dart';

class _SecondPageView extends StatefulWidget {
  const _SecondPageView();

  @override
  State<_SecondPageView> createState() => _SecondPageViewState();
}

class _SecondPageViewState extends State<_SecondPageView> with AutomaticKeepAliveClientMixin {
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
        padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ArrowBackPageView(),
            const Gap(25),
            BlocSelector<SignUpCubit, SignUpState, CoachType>(
              selector: (state) => state.coachType,
              builder: (context, coachType) {
                return Center(
                  child: DropdownButtonFormField<CoachType>(
                    borderRadius: BorderRadius.circular(12),
                    isExpanded: true,
                    iconEnabledColor: context.colorsX.onBackground,
                    value: coachType,
                    dropdownColor: context.colorsX.secondary,
                    enableFeedback: true,
                    items: CoachType.values.map((coachType) {
                      return DropdownMenuItem<CoachType>(
                        value: coachType,
                        child: DefaultTextStyle(
                          style: context.textThemeX.small.copyWith(
                            color: context.colorsX.background,
                          ),
                          child: Text(
                            coachType == CoachType.fitnessCoach
                                ? context.l10n.fitness
                                : coachType == CoachType.nutritionCoach
                                    ? context.l10n.nutrition
                                    : context.l10n.manager,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (CoachType? selectedType) {
                      if (selectedType != null) {
                        context.read<SignUpCubit>().coachTypeChanged(selectedType);
                      }
                    },
                    validator: (value) {
                      if (value == null) {
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

class _CompanyField extends StatelessWidget {
  const _CompanyField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: context.colorsX.background),
      decoration: InputDecoration(
        label: Text(
          context.l10n.company.capitalized,
          style: context.textThemeX.small.copyWith(color: context.colorsX.background),
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
          style: TextStyle(color: context.colorsX.background),
          decoration: InputDecoration(
            label: Text(
              context.l10n.phoneNumber.capitalized,
              style: context.textThemeX.small.copyWith(color: context.colorsX.background),
            ),
          ),
        );
      },
    );
  }
}
