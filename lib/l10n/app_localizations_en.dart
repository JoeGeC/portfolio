// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get ownerName => 'Joe Barker';

  @override
  String get portfolio => 'Portfolio';

  @override
  String get lightMode => 'Light mode';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get jobTitle => 'Native Android & Flutter Developer';

  @override
  String get github => 'GitHub';

  @override
  String get linkedIn => 'LinkedIn';

  @override
  String get contactMe => 'Contact Me';

  @override
  String get downloadCv => 'Download CV';

  @override
  String get featuredProjects => 'Featured Projects';

  @override
  String get viewAll => 'View All →';

  @override
  String get projects => 'Projects';

  @override
  String get projectsSubtitle =>
      'A showcase of my open source work. Tap a project to see the full README.';

  @override
  String get viewOnGithub => 'View on GitHub';

  @override
  String get blog => 'Blog';

  @override
  String get blogSubtitle =>
      'Thoughts on mobile development, architecture, and engineering.';

  @override
  String get noBlogPosts => 'No blog posts yet. Check back soon!';

  @override
  String get readMore => 'Read More';

  @override
  String get home => 'Home';

  @override
  String get postNotFound => 'Post not found';

  @override
  String errorLoadingPosts(String error) {
    return 'Error loading posts: $error';
  }

  @override
  String failedToLoadPost(String error) {
    return 'Failed to load post: $error';
  }
}
