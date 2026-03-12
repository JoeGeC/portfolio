abstract final class AppRoutes {
  static const home = '/';
  static const projects = '/projects';
  static const blog = '/blog';
  static const blogPostSlug = ':slug';
}

abstract final class AppStrings {
  static const appTitle = 'Joe Barker - Portfolio';
  static const ownerName = 'Joe Barker';
  static const portfolio = 'Portfolio';
  static const lightMode = 'Light mode';
  static const darkMode = 'Dark mode';
}

abstract final class PrefsKeys {
  static const themeMode = 'themeMode';
  static const themeDark = 'dark';
  static const themeLight = 'light';
}
