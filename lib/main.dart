import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_constants.dart';
import 'app_router.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(PrefsKeys.themeMode);
    if (saved != null) {
      setState(() {
        _themeMode = saved == PrefsKeys.themeDark
            ? ThemeMode.dark
            : ThemeMode.light;
      });
    }
  }

  Future<void> _toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    });
    await prefs.setString(
      PrefsKeys.themeMode,
      _themeMode == ThemeMode.dark ? PrefsKeys.themeDark : PrefsKeys.themeLight,
    );
  }

  late final _router = buildRouter(
    onToggleTheme: _toggleTheme,
    isDarkMode: () => _themeMode == ThemeMode.dark,
  );

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: AppStrings.appTitle,
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light(),
    darkTheme: AppTheme.dark(),
    themeMode: _themeMode,
    routerConfig: _router,
  );
}
