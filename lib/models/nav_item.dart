import 'package:flutter/material.dart';

class NavItem {
  final String label;
  final String path;
  final IconData icon;

  const NavItem({
    required this.label,
    required this.path,
    required this.icon,
  });
}
