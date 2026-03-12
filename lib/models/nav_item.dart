import 'package:flutter/material.dart';
import '../app_constants.dart';

class NavItem {
  final String label;
  final String path;
  final IconData icon;

  const NavItem({
    required this.label,
    required this.path,
    required this.icon,
  });

  static const destinations = [
    NavItem(label: 'Home', path: AppRoutes.home, icon: Icons.home),
    NavItem(label: 'Projects', path: AppRoutes.projects, icon: Icons.code),
    NavItem(label: 'Blog', path: AppRoutes.blog, icon: Icons.article),
  ];
}
