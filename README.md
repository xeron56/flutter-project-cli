# flutter-bloc-app-template

Opinionated Flutter starter that an AI agent (or a human) can extend with new
features without re-inventing the wiring. The repository is meant as a **base**
— clone it, change the package name and brand seed, and start adding feature
slices.

The template ships a small but realistic example surface: an **Auth flow**
(login screen, secure storage, redirect-aware router) and a **SpaceX launch
detail** screen that demonstrates the network → repository → bloc → UI path.

## What's included

| Concern              | Library / pattern                                                                 |
| -------------------- | ---------------------------------------------------------------------------------- |
| State management     | `flutter_bloc` (Bloc + Cubit), `freezed` for sealed states                         |
| Routing              | `go_router` with shell route, auth-aware redirect, 404 page                        |
| Forms                | `formz` validators                                                                 |
| Error model          | Sealed `Failure` + `Either<Failure, T>` (alias `Result<T>`) via `dartz`            |
| Networking           | `dio` + `retrofit` + interceptors (auth, retry, connectivity, talker logger)       |
| DI                   | `get_it` + `injectable` (codegen)                                                  |
| Storage              | `shared_preferences` + `flutter_secure_storage` for tokens                         |
| Theme                | Seed-based `ColorScheme.fromSeed` (one knob to rebrand)                            |
| Connectivity         | `connectivity_plus` + an offline banner widget                                     |
| Crash reporting      | `runZonedGuarded` + `FlutterError.onError` (drop your Sentry/Crashlytics in)       |
| Feature flags        | Tiny `FeatureFlags` over `SharedPreferences` with per-flavor static overrides      |
| Localization         | ARB + `intl_utils`; English, German, Portuguese, Ukrainian, Arabic (RTL demo)      |
| Images               | `cached_network_image`                                                             |
| Testing              | `bloc_test`, `mocktail`, sample tests under `test/`                                |

## Project layout

```
lib/
  app/                 # MaterialApp.router, lifecycle, localization
  app_runner.dart      # runZonedGuarded entry point
  bloc/theme/          # Global ThemeCubit + AppTheme enum
  config/              # AppConfig, BuildType, Environment, FeatureFlags
  constants/           # Dimens, icons
  data/
    auth/              # TokenStorage, AuthDataSource (mock-backed example)
    failure/           # Failure hierarchy + DioException → Failure mapper
    network/
      data_source/     # *DataSource abstractions
      interceptors/    # Auth, retry, connectivity, error mapper
      model/           # Network DTOs (retrofit + json_serializable)
      service/         # @RestApi services
    theme_storage.dart # Persists the user's AppTheme
  di/                  # @module classes + initDI()
  features/
    <feature>/
      bloc/            # Feature bloc(s)
      view/            # Screens
      widget/          # Feature-private widgets
      model/           # Feature-private models (e.g. formz inputs)
  l10n/                # ARB sources
  models/              # Domain resources shared across features
  repository/          # Domain-facing repositories
  routes/router.dart   # AppRoutes + buildRouter(authBloc)
  theme/               # MaterialTheme (seed-based)
  widgets/             # Cross-feature widgets
```

### Pattern to follow when adding a feature

1. Create `lib/features/<name>/` with `bloc/`, `view/`, `widget/`, `model/`.
2. If you need new data, add `lib/data/network/service/<name>/` for the
   retrofit service and `lib/data/network/data_source/` for the wrapper that
   returns `Future<Result<T>>`.
3. Add a `lib/repository/<name>_repository.dart` that converts DTOs to
   domain resources.
4. Register the new types in the matching `lib/di/di_*_module.dart` so
   `build_runner` wires them up.
5. Add a route in `lib/routes/router.dart`. If the screen lives behind the
   bottom-nav, add it to the `ShellRoute` block; otherwise add a top-level
   `GoRoute`.

## Build & run

```bash
# install deps
flutter pub get

# run codegen (freezed, json_serializable, retrofit, injectable, flutter_gen)
dart run build_runner build --delete-conflicting-outputs

# flavored launch
flutter run -t lib/main_dev.dart  --flavor dev
flutter run -t lib/main_qa.dart   --flavor qa
flutter run -t lib/main_prod.dart --flavor prod

# tests
flutter test
flutter analyze
```

`Makefile` has shortcuts for the common loops (`make`, `make gen`,
`make localize`, `make check`).

## Flavors

Each `main_*.dart` calls `Environment.init` with a `BuildType` and an
`AppConfig`. Override `apiBaseUrl`, `sentryDsn`, and static feature-flag
defaults per flavor — the rest of the app reads them via DI.

## Demo credentials

The mock `AuthDataSource` accepts **any well-formed email plus a password of
at least 6 characters** (e.g. `demo@example.com` / `secret1`). Replace
`MockAuthDataSource` with a real retrofit service when wiring a backend; the
rest of the auth pipeline stays untouched.

## Rebranding

Open [lib/theme/style.dart](lib/theme/style.dart#L4) and change `kBrandSeed`.
Material 3 derives the full light/dark palette from that one color.
