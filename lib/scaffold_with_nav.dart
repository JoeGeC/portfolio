import 'package:flutter/material.dart';
import 'app_constants.dart';
import 'widgets/nav_bar.dart';
import 'widgets/nav_drawer.dart';

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
    final isWide =
        MediaQuery.sizeOf(context).width > AppLayout.breakpointWide;

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
