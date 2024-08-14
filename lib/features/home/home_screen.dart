import 'package:btl/app/bloc/auth_bloc.dart';
import 'package:btl/app/constants.dart/default.dart';
import 'package:btl/features/home/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
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
      body: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          return switch (index) {
            0 => Scaffold(
                body: Align(
                  alignment: const Alignment(0, -1 / 3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Avatar(photo: user.photo),
                      const SizedBox(height: 4),
                      Text(user.email ?? '', style: textTheme.titleLarge),
                      const SizedBox(height: 4),
                      Text(user.name ?? '', style: textTheme.headlineSmall),
                    ],
                  ),
                ),
              ),
            1 => const Scaffold(
                body: Center(
                  child: Text('settings'),
                ),
              ),
            _ => Scaffold(
                body: Align(
                  alignment: const Alignment(0, -1 / 3),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Avatar(photo: user.photo),
                      const SizedBox(height: 4),
                      Text(user.email ?? '', style: textTheme.titleLarge),
                      const SizedBox(height: 4),
                      Text(user.name ?? '', style: textTheme.headlineSmall),
                    ],
                  ),
                ),
              ),
          };
        },
      ),
    );
  }
}
