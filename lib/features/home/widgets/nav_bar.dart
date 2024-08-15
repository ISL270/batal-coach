part of '../home_screen.dart';

class _NavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onDestinationSelected;

  const _NavBar({
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(35),
          right: Radius.circular(35),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          elevation: 3,
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
          onDestinationSelected: onDestinationSelected,
        ),
      ),
    );
  }
}
