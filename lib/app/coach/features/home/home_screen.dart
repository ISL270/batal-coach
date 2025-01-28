import 'package:btl/app/core/assets_gen/assets.gen.dart';
import 'package:btl/app/core/extension_methods/string_x.dart';
import 'package:btl/app/core/l10n/l10n.dart';
import 'package:btl/app/core/theming/app_colors_extension.dart';
import 'package:btl/app/widgets/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const HomeScreen({required this.navigationShell, Key? key})
      : super(key: key ?? const ValueKey('HomeScreen'));

  void _goBranch(int index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.ltr,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(35)),
          child: NavigationBar(
            onDestinationSelected: _goBranch,
            selectedIndex: navigationShell.currentIndex,
            destinations: [
              NavigationDestination(
                selectedIcon: SvgAsset(Assets.icons.dumbbell, color: context.colorsX.primary),
                icon: SvgAsset(Assets.icons.dumbbellOutlined),
                label: context.l10n.exercise(0).capitalizedDefinite,
              ),
              NavigationDestination(
                selectedIcon: SvgAsset(Assets.icons.sprint, color: context.colorsX.primary),
                icon: SvgAsset(Assets.icons.sprint),
                label: context.l10n.workout(0).capitalizedDefinite,
              ),
              NavigationDestination(
                selectedIcon: const Icon(Icons.person),
                icon: const Icon(Icons.person_outlined),
                label: context.l10n.client(0).capitalizedDefinite,
              ),
              NavigationDestination(
                selectedIcon: const Icon(Icons.settings),
                icon: const Icon(Icons.settings),
                label: context.l10n.settings.capitalizedDefinite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
