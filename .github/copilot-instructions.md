# Flutter BLoC Template — AI Instructions

You are extending a Flutter starter template. Follow the patterns documented
here exactly; the template is small on purpose so that AI-generated code stays
consistent. If something here conflicts with what you "usually" do, the
template wins.

---

## Stack

- **State**: `flutter_bloc` (Bloc + Cubit), `freezed` for sealed states.
- **Routing**: `go_router` with a shell route + auth-aware redirect.
- **DI**: `get_it` + `injectable` (codegen).
- **Networking**: `dio` + `retrofit`. Base URL comes from `AppConfig` via DI.
- **Error model**: sealed `Failure` + `Either<Failure, T>` (alias `Result<T>`).
- **Forms**: `formz` validators.
- **Storage**: `shared_preferences` for prefs, `flutter_secure_storage` for
  tokens.
- **Theme**: `ColorScheme.fromSeed(seedColor: kBrandSeed)` — single seed.
- **Networking polish**: cached_network_image, connectivity_plus banner.

---

## Layered architecture

```
UI (feature/view)         ──watches──▶  Bloc/Cubit
Bloc/Cubit                ──calls───▶  Repository
Repository                ──calls───▶  DataSource
DataSource                ──wraps──▶  retrofit service / SharedPreferences
```

Rules:

- **Data sources** return `Future<Result<T>>`. Catch exceptions in the
  datasource and run them through `mapErrorToFailure(...)`.
- **Repositories** return `Future<Result<DomainResource>>`. Convert
  `network_*` DTOs to domain `*Resource` types via `.toResource()`.
- **Blocs** consume `Result<T>` with `.fold((failure) => ..., (data) => ...)`.
  They emit typed states (sealed via freezed) that carry the `Failure` on
  error, never a plain `String`.
- Never `throw` across layer boundaries. Never put a `try/catch` in a bloc.
- Never call `Dio` directly from a bloc or a screen.

---

## Folder layout for a new feature

```
lib/features/<name>/
  bloc/        ← <Name>Bloc, <Name>Event, <Name>State (freezed)
  view/        ← screens / pages
  widget/      ← feature-private widgets
  model/       ← formz inputs, view-models, anything UI-shaped
```

If the feature needs new data:

```
lib/data/network/service/<name>/   ← retrofit @RestApi() class
lib/data/network/data_source/      ← <Name>DataSource abstract + impl
lib/repository/<name>_repository.dart
lib/models/<name>/                 ← domain *Resource types
```

After adding new injectable classes, run:

```
dart run build_runner build --delete-conflicting-outputs
```

---

## DI module pattern

```dart
@module
abstract class FooModule {
  @lazySingleton
  FooDataSource provideFooDataSource(FooService svc) =>
      FooNetworkDataSource(svc);

  @factoryMethod
  FooRepository provideFooRepository(FooDataSource ds) =>
      FooRepositoryImpl(ds);
}
```

Then expose feature-level blocs in `lib/di/app_bloc_providers.dart` if they're
app-scoped, or `BlocProvider(create: ...)` inside the screen if they're
scoped to that screen.

---

## Routing pattern

Routes live in `lib/routes/router.dart`. Use string constants on `AppRoutes`,
not raw strings:

```dart
context.go(AppRoutes.home);
context.go(AppRoutes.launchFor(7));
```

Auth redirect lives in `buildRouter`'s `redirect:` callback — it reads
`AuthBloc.state` and pushes to `/login` for unauthenticated users.
Screens behind the bottom-nav go under the `ShellRoute`; full-screen pages
become top-level `GoRoute`s.

---

## Bloc state pattern (freezed)

```dart
@Freezed()
abstract class FooState with _$FooState {
  const factory FooState.loading() = FooLoadingState;
  const factory FooState.success({required FooResource data}) =
      FooSuccessState;
  const factory FooState.error({required Failure failure}) = FooErrorState;
}
```

UI pattern-matches:

```dart
switch (state) {
  case FooLoadingState _:  return const LoadingContent();
  case FooSuccessState s:  return FooView(data: s.data);
  case FooErrorState e:    return ErrorContent(message: e.failure.message);
}
```

---

## Forms

Use `formz` inputs in `feature/model/`. The screen owns a `*FormCubit` whose
state mixes `FormzMixin` and holds the typed inputs. Submission dispatches
an event on the matching domain bloc (e.g. `AuthBloc`), not on the form
cubit.

See [lib/features/auth/](../lib/features/auth/) for the canonical example —
login screen, formz inputs, login cubit, `AuthBloc`.

---

## Flavors / config

Each `main_*.dart` calls `Environment.init` with an `AppConfig`. Read it via:

```dart
final config = Environment<AppConfig>.instance().config;
```

To use a different API base URL per flavor, change `apiBaseUrl` in the matching
`main_*.dart`.

---

## Theme

Open `lib/theme/style.dart` and change `kBrandSeed`. Material 3 derives the
rest from it. Don't hand-pick palette swatches.

User preference is stored as the `AppTheme` enum (`system` / `light` / `dark`)
via `ThemeCubit` → `ThemeRepository` → `SharedPreferencesThemeStorage`.

---

## What NOT to do

- ❌ Don't introduce new state-management libraries (no Provider-only, no
  Riverpod) — use Bloc/Cubit.
- ❌ Don't import retrofit services or `Dio` from UI / blocs.
- ❌ Don't throw exceptions across layer boundaries — use `Failure`.
- ❌ Don't add named-route navigation — use `go_router`'s `AppRoutes`.
- ❌ Don't duplicate the launch feature; treat it as a *pattern* reference,
  not as code to extend.
- ❌ Don't put logic in `index.dart` — it's just a barrel re-exports file.

---

## When you write new code

1. Match the existing folder shape.
2. Add a `@module` registration for any new repository / data source /
   service.
3. Run `dart run build_runner build --delete-conflicting-outputs` after
   adding freezed / json_serializable / retrofit / injectable annotations.
4. Run `flutter analyze` and `flutter test` before declaring the change done.
