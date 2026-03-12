import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_constants.dart';
import '../models/nav_item.dart';

class NavLink extends StatelessWidget {
  final NavItem item;
  final String currentPath;

  const NavLink({super.key, required this.item, required this.currentPath});

  bool get _isActive => item.path == AppRoutes.home
      ? currentPath == AppRoutes.home
      : currentPath.startsWith(item.path);

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
