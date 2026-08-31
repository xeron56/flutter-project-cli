# Flutter BLoC Template Agent Instructions

These instructions are for any AI coding agent working in this repository:
Codex, Claude, GitHub Copilot, Cursor, Windsurf, Gemini, or another assistant.

This repository is an empty Flutter application template. It intentionally has
no product-specific UI, no demo API, and no sample domain models. Preserve that
unless the user explicitly asks for a real feature.

## Agent Operating Rules

- Read the relevant files before editing. Do not guess project structure.
- Keep changes scoped to the user request.
- Prefer existing patterns over new abstractions.
- Do not silently remove user changes or unrelated files.
- Run `flutter analyze` and relevant tests after code changes when practical.
- If generated files become stale, run code generation instead of hand-editing
  generated output.
- For UI work, build the actual screen/flow, not a marketing landing page.
- For API work, keep networking out of screens and blocs.
- For template work, avoid adding sample business domains, fake APIs, or demo
  product screens.

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
- `mcp_toolkit` for AI Agent MCP runtime bridging (Arenukvern/mcp_flutter)
- ARB + `intl_utils`/Flutter localization generation

## Project Shape

```text
lib/
  app/                         App shell, localization delegates, lifecycle, agent MCP tools
  app_runner.dart              Bootstraps Flutter, DI, MCP binding, error reporting
  bloc/theme/                  Global ThemeCubit and AppTheme enum
  config/                      AppConfig, Environment, BuildType, FeatureFlags
  constants/                   Small shared constants and Material icon aliases
  data/
    failure/                   Failure hierarchy and Dio error mapper
    network/
      converter/               Shared JSON converters
      data_source/             Add data-source wrappers here
      interceptors/            Connectivity, retry, logging interceptors
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
  theme/                       Material theme and brand seed
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

## Dependency Injection

DI uses `get_it` + `injectable`.

- Register network services/data sources in `lib/di/di_network_module.dart`.
- Register repositories in `lib/di/di_repository_module.dart`.
- Register app-wide blocs/cubits in `lib/di/app_bloc_providers.dart`.
- Screen-local blocs should be created inside the screen with `BlocProvider`.
- Do not manually edit `lib/di/di_initializer.config.dart`.

## Code Generation

Run code generation after adding or changing any `@module`, `@injectable`,
`@RestApi`, `@freezed`, or `json_serializable` model:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Run localization generation after changing ARB files:

```bash
flutter gen-l10n
flutter pub run intl_utils:generate
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

Refresh the CLI from GitHub and create a project:

```bash
flutter pub global activate --source git \
  https://github.com/xeron56/flutter-project-cli.git && \
"$HOME/.pub-cache/bin/flutter_project_cli" \
  --project-name my_app \
  --package-name com.example.my_app \
  --output ../my_app
```

The CLI copies the template, skips build/cache/git files, renames Dart package
imports, Android namespace/applicationId, Kotlin package folders, iOS bundle
identifiers, and visible template names.

## Validation Checklist

For most code changes, run:

```bash
flutter analyze
flutter test
```

For new API models/services, also run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

For generated projects from the CLI, validate with:

```bash
flutter pub get
flutter analyze
```

## What Not To Do

- Do not re-add demo APIs or sample product screens.
- Do not call `Dio` or retrofit services from UI or blocs.
- Do not throw exceptions across data/repository/bloc boundaries.
- Do not introduce another state-management library.
- Do not put business logic in `index.dart`; it is only a barrel.
- Do not place feature-private widgets in `lib/widgets`.
- Do not leave `build_runner` outputs stale after adding generated types.
- Do not make broad dependency upgrades unless the user asks for that.
- Do not rename native packages manually; use the template CLI for new apps.

## Notes For Specific Agents

- Antigravity: leverage preconfigured `.agents/skills/` (guide, inspect, control, debug) and `mcp.json` to inspect live state and drive Flutter UI.
- Codex: install plugin via `flutter-mcp-toolkit init codex` (or `codex plugin marketplace add Arenukvern/mcp_flutter`).
- Claude: follow the file structure and result/error patterns exactly; do not
  invent alternative state management or service layers.
- GitHub Copilot/Copilot Chat: treat this file as the project source of truth
  for generated suggestions.
- Cursor/Windsurf/Gemini: prefer existing files as examples before creating new
  abstractions.
