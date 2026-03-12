import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// The portfolio owner's full name
  ///
  /// In en, this message translates to:
  /// **'Joe Barker'**
  String get ownerName;

  /// Generic portfolio label used in navigation drawer header
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get portfolio;

  /// Tooltip for switching to light theme
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get lightMode;

  /// Tooltip for switching to dark theme
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// Owner job title shown on home page
  ///
  /// In en, this message translates to:
  /// **'Native Android & Flutter Developer'**
  String get jobTitle;

  /// GitHub link chip label
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get github;

  /// LinkedIn link chip label
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get linkedIn;

  /// Contact email link chip label
  ///
  /// In en, this message translates to:
  /// **'Contact Me'**
  String get contactMe;

  /// CV download chip label
  ///
  /// In en, this message translates to:
  /// **'Download CV'**
  String get downloadCv;

  /// Heading for the featured projects section on the home page
  ///
  /// In en, this message translates to:
  /// **'Featured Projects'**
  String get featuredProjects;

  /// Button to navigate to the full projects list
  ///
  /// In en, this message translates to:
  /// **'View All →'**
  String get viewAll;

  /// Projects page title and nav item label
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// Subtitle shown at the top of the projects page
  ///
  /// In en, this message translates to:
  /// **'A showcase of my open source work. Tap a project to see the full README.'**
  String get projectsSubtitle;

  /// Link label to open a project on GitHub
  ///
  /// In en, this message translates to:
  /// **'View on GitHub'**
  String get viewOnGithub;

  /// Blog page title and nav item label
  ///
  /// In en, this message translates to:
  /// **'Blog'**
  String get blog;

  /// Subtitle shown at the top of the blog page
  ///
  /// In en, this message translates to:
  /// **'Thoughts on mobile development, architecture, and engineering.'**
  String get blogSubtitle;

  /// Empty state message when there are no blog posts
  ///
  /// In en, this message translates to:
  /// **'No blog posts yet. Check back soon!'**
  String get noBlogPosts;

  /// Link label on blog post cards to open the full post
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// Home nav item label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Error message when a blog post slug does not match any post
  ///
  /// In en, this message translates to:
  /// **'Post not found'**
  String get postNotFound;

  /// Error message shown when blog index fails to load
  ///
  /// In en, this message translates to:
  /// **'Error loading posts: {error}'**
  String errorLoadingPosts(String error);

  /// Error message shown when a blog post fails to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load post: {error}'**
  String failedToLoadPost(String error);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
