# Flutter BLoC Template Agent Instructions

This repository is an empty Flutter application template. It intentionally has
no product-specific UI, no demo API, and no sample domain models. Keep it that
way unless the user asks for a real feature.

Use the existing architecture exactly. The template is small so AI agents can
understand it quickly and generate consistent code.

## Stack

- Flutter + Material 3
- `flutter_bloc` for app and feature state
- `freezed` for sealed feature events/states and immutable DTOs
- `go_router` for navigation
- `dio` + `retrofit` for REST APIs
- `dartz` `Either<Failure, T>` through the `Result<T>` alias
- `get_it` + `injectable` for dependency injection
- `shared_preferences` for simple local preferences
- `connectivity_plus` for the global offline banner
- `intl_utils`/ARB for localization

## Project Shape

```text
lib/
  app/                         App shell, localization delegates, lifecycle
  app_runner.dart              Bootstraps Flutter, DI, error reporting
  bloc/theme/                  Global ThemeCubit and AppTheme enum
  config/                      AppConfig, Environment, BuildType, FeatureFlags
  constants/                   Small shared constants and Material icon aliases
  data/
    failure/                   Failure hierarchy and Dio error mapper
    network/
      converter/               Shared JSON converters
      data_source/             Add data-source wrappers here
      interceptors/            Connectivity, retry, and logging interceptors
      model/                   Add Network*Model DTOs here
      service/                 Add retrofit @RestApi services here
    theme_storage.dart         Theme persistence implementation
  di/                          Injectable modules and generated DI config
  features/
    home/view/home_screen.dart Tiny offline starter screen
    settings/view/             Theme settings screen
    <feature>/                 Add real feature folders here
  l10n/                        ARB localization sources
  models/                      Add shared domain resources here
  repository/                  Domain-facing repository contracts/impls
  routes/router.dart           AppRoutes and GoRouter setup
  theme/                       Generated Material theme and brand seed
  utils/                       Small cross-feature utilities
  widgets/                     Shared loading/error/empty/connectivity widgets
```

Empty folders with `.gitkeep` are intentional. They show where future API and
domain code should go.

## Required Feature Pattern

Create every real feature as a vertical slice:

```text
lib/features/<name>/
  bloc/
    <name>_bloc.dart
    <name>_event.dart
    <name>_state.dart
  view/
    <name>_screen.dart
  widget/
  model/
```

Use screen-local blocs by default:

```dart
return BlocProvider(
  create: (context) => ExampleBloc(
    RepositoryProvider.of<ExampleRepository>(context),
  )..add(const ExampleLoadEvent()),
  child: const ExampleView(),
);
```

Only add a bloc to `lib/di/app_bloc_providers.dart` when it must be app-scoped
and survive navigation.

## API Pattern

For API-backed features, add files in this order:

1. `lib/data/network/model/<feature>/network_<feature>_model.dart`
2. `lib/data/network/service/<feature>/<feature>_service.dart`
3. `lib/data/network/data_source/<feature>_network_data_source.dart`
4. `lib/models/<feature>/<feature>_resource.dart`
5. `lib/models/<feature>/<feature>_ext.dart`
6. `lib/repository/<feature>_repository.dart`
7. Register service/data source in `lib/di/di_network_module.dart`
8. Register repository in `lib/di/di_repository_module.dart`
9. Expose repository in `lib/di/app_repository_providers.dart` if screens use
   `RepositoryProvider.of<T>(context)`

Data sources must catch exceptions and return `Result<T>`:

```dart
class ExampleNetworkDataSource implements ExampleDataSource {
  ExampleNetworkDataSource(this._service);

  final ExampleService _service;

  @override
  Future<Result<NetworkExampleModel>> getExample(String id) async {
    try {
      return Right(await _service.fetchExample(id));
    } catch (error, stackTrace) {
      return Left(mapErrorToFailure(error, stackTrace));
    }
  }
}
```

Repositories convert DTOs to domain resources and also return `Result<T>`:

```dart
class ExampleRepositoryImpl implements ExampleRepository {
  ExampleRepositoryImpl(this._dataSource);

  final ExampleDataSource _dataSource;

  @override
  Future<Result<ExampleResource>> getExample(String id) async {
    final result = await _dataSource.getExample(id);
    return result.map((model) => model.toResource());
  }
}
```

Blocs fold results. Do not put `try/catch` in blocs:

```dart
final result = await _repository.getExample(event.id);
emit(
  result.fold(
    (failure) => ExampleState.error(failure: failure),
    (data) => ExampleState.success(data: data),
  ),
);
```

## Routing

Routes live only in `lib/routes/router.dart`.

- Add route constants to `AppRoutes`.
- Use `context.go(AppRoutes.someRoute)` or helper methods like
  `AppRoutes.detailFor(id)`.
- Do not navigate with raw string literals from screens.
- Keep `/` as the offline template home until the real app has a home feature.

## DI and Code Generation

After adding or changing any `@module`, `@injectable`, `@RestApi`, `@freezed`,
or `json_serializable` model, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generated files are committed in this template. Do not hand-edit generated
files unless generation is unavailable and the user approves.

## Flavors

Entrypoints:

- `lib/main.dart`: default local debug entrypoint
- `lib/main_dev.dart`: dev flavor
- `lib/main_qa.dart`: QA flavor
- `lib/main_prod.dart`: production flavor

Each entrypoint initializes `Environment` with `AppConfig`. Put real API base
URLs there when a project has a backend.

VS Code launch configs are in `.vscode/launch.json`.

## Template CLI

Use `tool/template_cli.dart` to create a new project from this template:

```bash
dart run tool/template_cli.dart \
  --project-name my_app \
  --package-name com.example.my_app \
  --output ../my_app
```

The CLI copies the template, skips build/cache/git files, renames Dart package
imports, Android namespace/applicationId, Kotlin package folders, iOS bundle
identifiers, and visible template names.

## What Not To Do

- Do not re-add demo APIs or sample product screens.
- Do not call `Dio` or retrofit services from UI or blocs.
- Do not throw exceptions across data/repository/bloc boundaries.
- Do not introduce another state-management library.
- Do not put business logic in `index.dart`; it is only a barrel.
- Do not place feature-private widgets in `lib/widgets`.
- Do not leave `build_runner` outputs stale after adding generated types.
