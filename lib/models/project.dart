import '../app_constants.dart';

class Project {
  final String title;
  final String description;
  final String repo;
  final String imageAsset;
  final List<String> technologies;

  const Project({
    required this.title,
    required this.description,
    required this.repo,
    required this.imageAsset,
    required this.technologies,
  });

  String get githubUrl => '${AppUrls.githubRepoBase}$repo';

  String get readmePageUrl => '${AppUrls.githubRepoBase}$repo${AppUrls.githubReadmeSuffix}';

  String get readmeUrl =>
      '${AppUrls.rawGithubRepoBase}$repo${AppUrls.rawGithubMainReadmeSuffix}';

  static const List<Project> all = [
    Project(
      title: 'Native Android Movie Database',
      description:
          'Written in Jetpack Compose, using Retrofit, Room, Hilt, Stateflow, Coroutines, and MVVM. '
          'Extensive unit tests in JUnit and Mockito. '
          'Clean architecture, modularised by layer.',
      repo: 'MovieDB-Android',
      imageAsset: AppAssets.movieDbAndroid,
      technologies: [
        'Kotlin',
        'Jetpack Compose',
        'Retrofit',
        'Room',
        'Hilt',
        'MVVM',
        'JUnit',
        'Mockito',
      ],
    ),
    Project(
      title: 'Cross-Platform Pokedex App',
      description:
          'Built with Flutter using Dio, SQLite, L10n, GetIt and MVVM. '
          'Extensive unit testing. '
          'Clean architecture modularised by feature.',
      repo: 'PokemonDbFlutter',
      imageAsset: AppAssets.pokemonDbFlutter,
      technologies: [
        'Flutter',
        'Dart',
        'Dio',
        'SQLite',
        'L10n',
        'GetIt',
        'MVVM',
      ],
    ),
  ];
}
