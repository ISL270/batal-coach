import 'package:btl/app/constants.dart/default.dart';
import 'package:btl/features/dashboard/dashboard_screen.dart';
import 'package:btl/features/settings/settings_screen.dart';
import 'package:flutter/material.dart';

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
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.ltr,
        child: NavigationBar(
          selectedIndex: _currentIndex,
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.dashboard),
              icon: Icon(Icons.dashboard_outlined),
              label: 'Dashboard',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
          onDestinationSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.animateToPage(
              _currentIndex,
              curve: Default.curve,
              duration: Default.duration,
            );
          },
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          return switch (index) {
            0 => const DashboardScreen(),
            1 => const SettingsScreen(),
            _ => const DashboardScreen(),
          };
        },
      ),
    );
  }
}
