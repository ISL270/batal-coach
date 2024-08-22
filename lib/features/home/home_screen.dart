import 'package:btl/core/constants.dart/default.dart';
import 'package:btl/core/enums/language.dart';
import 'package:btl/core/extensions/bloc_x.dart';
import 'package:btl/core/l10n/l10n.dart';
import 'package:btl/features/settings/settings_screen.dart';
import 'package:btl/features/workout_builder/presentation/workout_builder_screen.dart';
import 'package:flutter/material.dart';

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
        physics: const NeverScrollableScrollPhysics(),
        reverse: context.settingsBloc.state.language.isArabic,
        controller: _pageController,
        itemBuilder: (context, index) {
          return switch (index) {
            0 => const WorkoutBuilderScreen(),
            1 => const SettingsScreen(),
            _ => const WorkoutBuilderScreen(),
          };
        },
      ),
    );
  }
}
