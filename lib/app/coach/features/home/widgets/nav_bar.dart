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
              selectedIcon: SvgAsset(
                Assets.icons.dumbbell,
                color: context.colorsX.primary,
              ),
              icon: SvgAsset(Assets.icons.dumbbellOutlined),
              label: context.l10n.workout(0).capitalizedDefinite,
            ),
            NavigationDestination(
              selectedIcon: const Icon(Icons.person),
              icon: const Icon(Icons.person_outlined),
              label: context.l10n.settings.capitalizedDefinite,
            ),
            NavigationDestination(
              selectedIcon: const Icon(Icons.settings),
              icon: const Icon(Icons.settings_outlined),
              label: context.l10n.settings.capitalizedDefinite,
            ),
          ],
        ),
      ),
    );
  }
}
