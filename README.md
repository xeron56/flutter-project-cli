# Flutter BLoC App Template

Empty Flutter starter for building API-backed apps with a consistent BLoC,
repository, network, DI, routing, flavor, localization, and theme structure.

The template intentionally contains no demo API and no sample product domain.
The first screen is an offline placeholder so new projects do not make network
calls before real backend details are added.

## Included

| Concern | Pattern |
| --- | --- |
| State | `flutter_bloc` with Bloc/Cubit |
| Routing | `go_router` with route constants |
| Network | `dio`, `retrofit`, retry/connectivity/logging interceptors |
| Errors | `Failure` hierarchy and `Result<T> = Either<Failure, T>` |
| DI | `get_it` plus `injectable` modules/codegen |
| Storage | `shared_preferences` theme storage |
| Theme | Material 3 theme generated from one seed color |
| Localization | ARB + `intl_utils` |
| Flavors | `dev`, `qa`, `prod` entrypoints and native configs |
| Testing | Flutter test setup with a connectivity banner test |

## Structure

```text
lib/
  app/                         App shell, localization, lifecycle
  app_runner.dart              Error boundary, DI init, runApp
  bloc/theme/                  Global ThemeCubit
  config/                      AppConfig, Environment, BuildType, FeatureFlags
  data/
    failure/                   Failure and error mapper
    network/
      data_source/             Add API data sources here
      interceptors/            Dio interceptors
      model/                   Add network DTOs here
      service/                 Add retrofit services here
    theme_storage.dart
  di/                          Injectable modules
  features/
    home/                      Offline starter screen
    settings/                  Theme settings screen
  models/                      Add domain resources here
  repository/                  Add repository contracts/impls here
  routes/router.dart
  theme/
  utils/
  widgets/
```

## Create a New Project From This Template

```bash
# Refresh the CLI from GitHub, then create a project.
flutter pub global activate --source git \
  https://github.com/xeron56/flutter-project-cli.git && \
flutter pub global run flutter_bloc_app_template:flutter_project_cli \
  --project-name my_app \
  --package-name com.example.my_app \
  --output ../my_app
```

Options:

```text
--project-name   Dart package/app name, snake_case, for example my_app
--package-name   Native package id, for example com.example.my_app
--output         Target directory for the generated project
--force          Replace output directory if it already exists
```

For a shorter command after activation, add Dart pub cache executables to your
shell path:

```bash
export PATH="$PATH:$HOME/.pub-cache/bin"
```

Then you can run:

```bash
flutter_project_cli \
  --project-name my_app \
  --package-name com.example.my_app \
  --output ../my_app
```

Then run:

```bash
cd ../my_app
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test
```

## Run This Template

```bash
flutter pub get
flutter run -t lib/main_dev.dart --flavor dev
```

Other flavors:

```bash
flutter run -t lib/main_qa.dart --flavor qa
flutter run -t lib/main_prod.dart --flavor prod
```

VS Code launch configs are already set up in `.vscode/launch.json`.

## Add a Feature

Create a vertical slice:

```text
lib/features/<name>/
  bloc/
  view/
  widget/
  model/
```

For API-backed features, add:

```text
lib/data/network/model/<name>/
lib/data/network/service/<name>/
lib/data/network/data_source/<name>_network_data_source.dart
lib/models/<name>/
lib/repository/<name>_repository.dart
```

Register services/data sources in `lib/di/di_network_module.dart`, register
repositories in `lib/di/di_repository_module.dart`, and rerun codegen.

## Codegen

```bash
dart run build_runner build --delete-conflicting-outputs
flutter pub run intl_utils:generate
fluttergen -c pubspec.yaml
```

## Checks

```bash
flutter analyze
flutter test
```

## Rebrand

- App title: `lib/l10n/intl_en.arb`
- Package name: use `flutter_project_cli`
- Theme seed: `lib/theme/style.dart`
- API base URL: `lib/main_dev.dart`, `lib/main_qa.dart`, `lib/main_prod.dart`
