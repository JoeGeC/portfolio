# Clean Architecture in Flutter: A Practical Guide

**March 10, 2026**

When building Flutter apps that scale, having a solid architecture isn't optional — it's essential. In this post, I'll walk through how I structure my Flutter projects using clean architecture, and why it makes testing and maintenance so much easier.

## Why Clean Architecture?

Most tutorials show you how to build a feature. Few show you how to build a feature that won't become a nightmare six months later. Clean architecture solves this by enforcing **separation of concerns** through distinct layers:

- **Presentation** — Widgets, pages, and state management
- **Domain** — Business logic, entities, and use cases
- **Data** — Repositories, data sources, and models

Each layer only depends on the one below it, never the other way around. This means your business logic doesn't care whether data comes from an API, a database, or a mock in a test.

## Project Structure

Here's how I typically organise a feature module:

```
lib/
└── features/
    └── pokemon/
        ├── presentation/
        │   ├── pages/
        │   │   └── pokemon_list_page.dart
        │   ├── widgets/
        │   │   └── pokemon_card.dart
        │   └── viewmodel/
        │       └── pokemon_list_viewmodel.dart
        ├── domain/
        │   ├── entities/
        │   │   └── pokemon.dart
        │   ├── repositories/
        │   │   └── pokemon_repository.dart
        │   └── usecases/
        │       └── get_pokemon_list.dart
        └── data/
            ├── models/
            │   └── pokemon_model.dart
            ├── datasources/
            │   ├── pokemon_remote_datasource.dart
            │   └── pokemon_local_datasource.dart
            └── repositories/
                └── pokemon_repository_impl.dart
```

## The Domain Layer

This is the heart of your app. Entities are plain Dart classes with no Flutter or package dependencies:

```dart
class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;

  const Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
  });
}
```

Use cases encapsulate a single piece of business logic:

```dart
class GetPokemonList {
  final PokemonRepository repository;

  GetPokemonList(this.repository);

  Future<List<Pokemon>> call({int offset = 0, int limit = 20}) {
    return repository.getPokemonList(offset: offset, limit: limit);
  }
}
```

## The Data Layer

Repository implementations live here. They coordinate between remote and local data sources:

```dart
class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remote;
  final PokemonLocalDataSource local;

  PokemonRepositoryImpl({required this.remote, required this.local});

  @override
  Future<List<Pokemon>> getPokemonList({int offset = 0, int limit = 20}) async {
    try {
      final models = await remote.fetchPokemonList(offset: offset, limit: limit);
      await local.cachePokemonList(models);
      return models.map((m) => m.toEntity()).toList();
    } catch (_) {
      final cached = await local.getCachedPokemonList();
      return cached.map((m) => m.toEntity()).toList();
    }
  }
}
```

Notice the offline-first pattern: fetch from the network, cache locally, and fall back to the cache on failure.

## Why This Pays Off

1. **Testability** — Each layer can be tested in isolation. Mock the repository to test the use case. Mock the use case to test the viewmodel. No HTTP calls or databases needed.
2. **Flexibility** — Swapping SQLite for Hive? Only the data layer changes. Migrating from Provider to Riverpod? Only the presentation layer changes.
3. **Onboarding** — New team members can understand one feature without understanding the whole app.

## Key Takeaways

- Keep your domain layer **free of external dependencies**
- Use **interfaces** (abstract classes) at layer boundaries
- Prefer **constructor injection** for dependencies — it makes testing trivial
- Modularise by **feature**, not by type

Clean architecture adds a bit of boilerplate upfront, but every project I've used it on has been easier to maintain, easier to test, and easier to extend. If you want to see it in action, check out my [Pokedex Flutter project](/projects/PokemonDbFlutter) — it follows these exact patterns.
