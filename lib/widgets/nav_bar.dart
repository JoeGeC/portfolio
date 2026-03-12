import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_constants.dart';
import '../l10n/l10n.dart';
import '../models/nav_destinations.dart';
import 'nav_link.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const NavBar({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > AppLayout.breakpointWide;
    final currentPath = GoRouterState.of(context).uri.toString();

    return AppBar(
      title: _AppBarTitle(),
      actions: [
        if (isWide) ...[
          ...navDestinations(context.l10n).map(
            (item) => NavLink(item: item, currentPath: currentPath),
          ),
          const SizedBox(width: 8),
        ],
        _ThemeToggleButton(
          isDarkMode: isDarkMode,
          onToggle: onToggleTheme,
        ),
        const SizedBox(width: 8),
      ],
      leading: isWide ? null : _DrawerMenuButton(),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.go(AppRoutes.home),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(
            context.l10n.ownerName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      );
}

class _ThemeToggleButton extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggle;

  const _ThemeToggleButton({required this.isDarkMode, required this.onToggle});

  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
        tooltip: isDarkMode ? context.l10n.lightMode : context.l10n.darkMode,
        onPressed: onToggle,
      );
}

class _DrawerMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Builder(
        builder: (ctx) => IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(ctx).openDrawer(),
        ),
      );
}
