part of '../sign_up_screen.dart';

class _CoachPageView extends StatefulWidget {
  const _CoachPageView();

  @override
  State<_CoachPageView> createState() => _CoachPageViewState();
}

class _CoachPageViewState extends State<_CoachPageView> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 50.h, right: 20.w, left: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ArrowBackButton(),
            const Gap(25),
            BlocSelector<SignUpCubit, SignUpState, CoachType>(
              selector: (state) => state.coachType,
              builder: (context, coachType) {
                return Center(
                  child: DropdownButtonFormField<CoachType>(
                    decoration: InputDecoration(
                      border: _signUpOutLinedInputBorder(context),
                      enabledBorder: _signUpOutLinedInputBorder(context),
                      focusedBorder: _signUpOutLinedInputBorder(context),
                      disabledBorder: _signUpOutLinedInputBorder(context),
                    ),
                    borderRadius: BorderRadius.circular(12),
                    isExpanded: true,
                    iconEnabledColor: context.colorsX.background,
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
                    onChanged: (CoachType? selectedType) => selectedType != null
                        ? context.read<SignUpCubit>().coachTypeChanged(selectedType)
                        : null,
                    validator: (value) => value != null ? context.l10n.selectrole : null,
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
          '${context.l10n.companyname.capitalized} (${context.l10n.optional.capitalized})',
          style: context.textThemeX.small.copyWith(color: context.colorsX.background),
        ),
        border: _signUpOutLinedInputBorder(context),
        enabledBorder: _signUpOutLinedInputBorder(context),
        focusedBorder: _signUpOutLinedInputBorder(context),
        disabledBorder: _signUpOutLinedInputBorder(context),
      ),
      onChanged: (companyName) => context.read<SignUpCubit>().companyNameChanged(companyName),
    );
  }
}
