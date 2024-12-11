import 'package:btl/app/core/extension_methods/bloc_x.dart';
import 'package:btl/app/core/extension_methods/context_x.dart';
import 'package:btl/app/core/extension_methods/english_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/l10n/language.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/features/authentication/domain/models/coach_type.dart';
import 'package:btl/app/features/settings/settings/settings_bloc.dart';
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

part 'widgets/first_page_view.dart';
part 'widgets/second_page_view.dart';

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
                    children: const [
                      _FirstPageView(),
                      _SecondPageView(),
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
