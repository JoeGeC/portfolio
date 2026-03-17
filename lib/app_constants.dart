abstract final class AppRoutes {
  static const home = '/';
  static const projects = '/projects';
  static const blog = '/blog';
  static const blogPostSlug = ':slug';
  static const slugParam = 'slug';
}

abstract final class AppStrings {
  static const appTitle = 'Joe Barker - Portfolio';
}

abstract final class PrefsKeys {
  static const themeMode = 'themeMode';
  static const themeDark = 'dark';
  static const themeLight = 'light';
}

abstract final class AppAssets {
  static const profilePicture = 'assets/images/profile_picture.jpg';
  static const movieDbAndroid = 'assets/images/moviedb-android.png';
  static const pokemonDbFlutter = 'assets/images/pokemondb-flutter.png';
  static const blogIndexJson = 'assets/blog/blog_index.json';
  static const blogAssetPrefix = 'assets/blog/';
}

abstract final class AppUrls {
  static const github = 'https://github.com/joegec';
  static const githubRepoBase = 'https://github.com/joegec/';
  static const githubReadmeSuffix = '#readme';
  static const rawGithubRepoBase = 'https://raw.githubusercontent.com/joegec/';
  static const rawGithubMainReadmeSuffix = '/main/README.md';
  static const linkedIn = 'https://linkedin.com/in/joe-barker-mobile-developer';
  static const email = 'mailto:joe.joeb29@gmail.com';
  static const cv = 'Joe_Barker_CV.pdf';
}

abstract final class AppLayout {
  static const breakpointWide = 600.0;
  static const contentMaxWidth = 800.0;
  static const pagePaddingH = 24.0;
  static const pagePaddingV = 40.0;
  static const latestPostsCount = 2;
}
