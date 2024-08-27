import 'package:btl/core/assets_gen/assets.gen.dart';
import 'package:btl/core/constants/default.dart';
import 'package:btl/core/extensions/bloc_x.dart';
import 'package:btl/core/extensions/getit_x.dart';
import 'package:btl/core/extensions/string_x.dart';
import 'package:btl/core/injection/injection.dart';
import 'package:btl/core/l10n/l10n.dart';
import 'package:btl/core/l10n/language.dart';
import 'package:btl/core/theming/app_colors_extension.dart';
import 'package:btl/features/exercise/presentation/bloc/exercise_bloc.dart';
import 'package:btl/features/exercise/presentation/exercises_screen.dart';
import 'package:btl/features/settings/settings_screen.dart';
import 'package:btl/widgets/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const name = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _NavBar(
        currentIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.animateToPage(
            _currentIndex,
            curve: Default.curve,
            duration: Default.duration,
          );
        },
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        reverse: context.settingsBloc.state.language.isArabic,
        itemBuilder: (context, index) => switch (index) {
          0 => BlocProvider(
              create: (context) => ExerciseBloc(getIt.exerciseRepo),
              child: const ExercisesScreen(),
            ),
          1 => const SettingsScreen(),
          _ => BlocProvider(
              create: (context) => ExerciseBloc(getIt.exerciseRepo),
              child: const ExercisesScreen(),
            ),
        },
      ),
    );
  }
}
