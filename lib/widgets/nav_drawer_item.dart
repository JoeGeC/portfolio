import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../app_constants.dart';
import '../models/nav_item.dart';

class NavDrawerItem extends StatelessWidget {
  final NavItem item;
  final String currentPath;

  const NavDrawerItem({
    super.key,
    required this.item,
    required this.currentPath,
  });

  bool get _isActive => item.path == AppRoutes.home
      ? currentPath == AppRoutes.home
      : currentPath.startsWith(item.path);

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
