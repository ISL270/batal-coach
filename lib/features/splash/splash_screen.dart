import 'package:btl/app/theming/app_colors_extension.dart';
import 'package:btl/app/theming/text_theme_extension.dart';
import 'package:btl/features/home/home_screen.dart';
import 'package:btl/features/splash/bloc/splash_bloc.dart';
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
          context.goNamed(HomeScreen.name);
        }
      },
      child: Scaffold(
        body: Center(
          child: Text(
            'BTL',
            style: context.textThemeX.large.copyWith(
              fontSize: 25,
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
