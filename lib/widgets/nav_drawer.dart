import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_constants.dart';
import '../models/nav_item.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.toString();
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: theme.colorScheme.primaryContainer),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  AppStrings.ownerName,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.portfolio,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          ...NavItem.destinations.map(
            (item) => _DrawerItem(item: item, currentPath: currentPath),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final NavItem item;
  final String currentPath;

  const _DrawerItem({required this.item, required this.currentPath});

  bool get _isActive {
    if (item.path == AppRoutes.home) return currentPath == AppRoutes.home;
    return currentPath.startsWith(item.path);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(item.icon),
      title: Text(item.label),
      selected: _isActive,
      onTap: () {
        Navigator.pop(context);
        context.go(item.path);
      },
    );
  }
}
