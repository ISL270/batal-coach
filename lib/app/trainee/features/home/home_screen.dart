import 'package:batal/core/constants/default.dart';
import 'package:batal/core/extension_methods/string_x.dart';
import 'package:btl/app/core/assets_gen/assets.gen.dart';
import 'package:btl/app/core/extension_methods/bloc_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/l10n/language.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/features/settings/settings/settings_bloc.dart';
import 'package:btl/app/features/settings/settings_screen.dart';
import 'package:btl/app/widgets/svg_asset.dart';
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
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        reverse: context.settingsBloc.state.settings.language.isArabic,
        itemBuilder: (context, index) => switch (index) {
          0 => const Scaffold(
              body: Center(
                child: Text('Trainee'),
              ),
            ),
          1 => const SettingsScreen(),
          _ => const Scaffold(
              body: Center(
                child: Text('Trainee'),
              ),
            ),
        },
      ),
    );
  }
}
