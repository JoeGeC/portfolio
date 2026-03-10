import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        onTap: () => context.go('/'),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(
            'Joe Barker',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
      actions: [
        if (isWide) ...[
          _NavLink(label: 'Home', path: '/', currentPath: currentPath),
          _NavLink(
              label: 'Projects', path: '/projects', currentPath: currentPath),
          _NavLink(label: 'Blog', path: '/blog', currentPath: currentPath),
          const SizedBox(width: 8),
        ],
        IconButton(
          icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
          tooltip: isDarkMode ? 'Light mode' : 'Dark mode',
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
                  'Joe Barker',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Portfolio',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          _DrawerItem(
            icon: Icons.home,
            label: 'Home',
            path: '/',
            currentPath: currentPath,
          ),
          _DrawerItem(
            icon: Icons.code,
            label: 'Projects',
            path: '/projects',
            currentPath: currentPath,
          ),
          _DrawerItem(
            icon: Icons.article,
            label: 'Blog',
            path: '/blog',
            currentPath: currentPath,
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final String path;
  final String currentPath;

  const _NavLink({
    required this.label,
    required this.path,
    required this.currentPath,
  });

  bool get _isActive {
    if (path == '/') return currentPath == '/';
    return currentPath.startsWith(path);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: () => context.go(path),
      child: Text(
        label,
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

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String path;
  final String currentPath;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.path,
    required this.currentPath,
  });

  bool get _isActive {
    if (path == '/') return currentPath == '/';
    return currentPath.startsWith(path);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      selected: _isActive,
      onTap: () {
        Navigator.pop(context);
        context.go(path);
      },
    );
  }
}
