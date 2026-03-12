import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_constants.dart';
import '../models/nav_item.dart';

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
    final isWide = MediaQuery.sizeOf(context).width > 600;
    final currentPath = GoRouterState.of(context).uri.toString();

    return AppBar(
      title: GestureDetector(
        onTap: () => context.go(AppRoutes.home),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(
            AppStrings.ownerName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      actions: [
        if (isWide) ...[
          ...NavItem.destinations.map(
            (item) => _NavLink(item: item, currentPath: currentPath),
          ),
          const SizedBox(width: 8),
        ],
        IconButton(
          icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
          tooltip: isDarkMode ? AppStrings.lightMode : AppStrings.darkMode,
          onPressed: onToggleTheme,
        ),
        const SizedBox(width: 8),
      ],
      leading: isWide
          ? null
          : Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final NavItem item;
  final String currentPath;

  const _NavLink({required this.item, required this.currentPath});

  bool get _isActive {
    if (item.path == AppRoutes.home) return currentPath == AppRoutes.home;
    return currentPath.startsWith(item.path);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: () => context.go(item.path),
      child: Text(
        item.label,
        style: TextStyle(
          color: _isActive
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface,
          fontWeight: _isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
