import 'package:flutter/material.dart';
import 'widgets/nav_bar.dart';

class ScaffoldWithNav extends StatelessWidget {
  final Widget child;
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const ScaffoldWithNav({
    super.key,
    required this.child,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 600;

    return Scaffold(
      appBar: NavBar(
        onToggleTheme: onToggleTheme,
        isDarkMode: isDarkMode,
      ),
      drawer: isWide ? null : const NavDrawer(),
      body: child,
    );
  }
}
