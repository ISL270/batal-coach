import 'package:btl/app/core/extension_methods/getit_x.dart';
import 'package:btl/app/core/injection/injection.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/core/theming/text_theme_extension.dart';
import 'package:btl/app/features/splash/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const name = 'splash';

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashSuccess) {
          context.goNamed(getIt.authBloc.homeNamedRoute);
        }
      },
      child: Scaffold(
        body: Center(
          child: Text(
            'BTL',
            style: context.textThemeX.heading.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
              color: context.colorsX.primary,
            ),
          ),
        ),
      ),
    );
  }
}
