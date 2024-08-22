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
          onDestinationSelected: onDestinationSelected,
          destinations: [
            NavigationDestination(
              selectedIcon: const Icon(Icons.fitness_center),
              icon: const Icon(Icons.fitness_center_outlined),
              label: context.l10n.exercise(1).definite.capitalize(),
            ),
            NavigationDestination(
              label: context.l10n.settings.definite,
              selectedIcon: const Icon(Icons.settings),
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
