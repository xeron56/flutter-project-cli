# Flutter BLoC Template — AI Instructions

You are extending a Flutter starter template. Follow the patterns documented
here exactly; the template is small on purpose so that AI-generated code stays
consistent. If something here conflicts with what you "usually" do, the
template wins.

---

## Stack

- **State**: `flutter_bloc` (Bloc + Cubit), `freezed` for sealed states.
- **Routing**: `go_router` with a shell route for bottom-nav tabs.
- **DI**: `get_it` + `injectable` (codegen via `injectable_generator`).
- **Networking**: `dio` + `retrofit` (codegen via `retrofit_generator`). Base URL comes from `AppConfig` via DI.
- **Error model**: sealed `Failure` + `Either<Failure, T>` (alias `Result<T>` from `dartz`).
- **Storage**: `shared_preferences` for user preferences.
- **Theme**: `ColorScheme.fromSeed` — single seed color in `lib/theme/style.dart`.
- **Networking polish**: `connectivity_plus` offline banner.

---

## Layered architecture

```
UI (feature/view)         ──watches──▶  Bloc/Cubit
Bloc/Cubit                ──calls───▶  Repository
Repository                ──calls───▶  DataSource
DataSource                ──wraps──▶  retrofit @RestApi() service
```

Rules:

- **Data sources** return `Future<Result<T>>`. Catch exceptions inside the
  datasource and pass them through `mapErrorToFailure(...)`. Never let
  exceptions escape the data layer.
- **Repositories** return `Future<Result<DomainResource>>`. Convert
  `Network*Model` DTOs to domain `*Resource` types via `.toResource()`.
- **Blocs** consume `Result<T>` with `.fold((failure) => ..., (data) => ...)`.
  Emit typed freezed states carrying the `Failure` on error, never a plain
  `String`.
- Never `throw` across layer boundaries.
- Never put a `try/catch` in a bloc.
- Never call `Dio` or a retrofit service directly from a bloc or a screen.

---

## Folder layout for a new feature

```
lib/features/<name>/
  bloc/        ← <Name>Bloc, <Name>Event, <Name>State (freezed)
  view/        ← screens / pages
  widget/      ← feature-private widgets
```

If the feature needs new data:

```
lib/data/network/service/<name>/   ← retrofit @RestApi() class + generated .g.dart
lib/data/network/model/<name>/     ← freezed + json_serializable Network*Model DTOs
lib/data/network/data_source/      ← <Name>DataSource abstract + impl
lib/repository/<name>_repository.dart
lib/models/<name>/                 ← domain *Resource types (pure Dart, no JSON)
```

After adding new injectable / freezed / retrofit / json_serializable classes run:

```
dart run build_runner build --delete-conflicting-outputs
```

---

## Retrofit service pattern

```dart
// lib/data/network/service/foo/foo_service.dart
@RestApi()
abstract class FooService {
  factory FooService(Dio dio) = _FooService;

  @GET('foo/{id}')
  Future<NetworkFooModel> fetchFoo(@Path('id') int id);

  @GET('foo')
  Future<List<NetworkFooModel>> fetchAll();
}
```

Register in `NetworkModule` (`lib/di/di_network_module.dart`):

```dart
@lazySingleton
FooService provideFooService(Dio dio) => FooService(dio);

@lazySingleton
FooDataSource provideFooDataSource(FooService svc) => FooNetworkDataSource(svc);
```

---

## DI module pattern

```dart
// lib/di/di_repository_module.dart
@module
abstract class RepositoryModule {
  @factoryMethod
  FooRepository provideFooRepository(FooDataSource ds) =>
      FooRepositoryImpl(ds);
}
```

Expose a feature bloc in `lib/di/app_bloc_providers.dart` only if it must
survive navigation (app-scoped). If it's screen-local, create it with
`BlocProvider(create: ...)` inside the screen widget instead.

---

## Routing pattern

Routes live in `lib/routes/router.dart` as constants on `AppRoutes`.
The router is a top-level `final appRouter = GoRouter(...)` singleton.

```dart
// Adding a new route
abstract final class AppRoutes {
  static const foo = '/foo';
  static const fooDetail = '/foo/:id';
  static String fooFor(int id) => '/foo/$id';
}
```

Navigate with:

```dart
context.go(AppRoutes.foo);
context.go(AppRoutes.fooFor(7));
```

Screens that belong in the bottom-nav go under the `ShellRoute`.
Full-screen detail pages go as top-level `GoRoute`s (no bottom-nav).

---

## Bloc state pattern (freezed)

```dart
// lib/features/foo/bloc/foo_state.dart
part of 'foo_bloc.dart';

@Freezed()
abstract class FooState with _$FooState {
  const factory FooState.loading() = FooLoadingState;
  const factory FooState.success({required FooResource data}) = FooSuccessState;
  const factory FooState.error({required Failure failure}) = FooErrorState;
}
```

Bloc:

```dart
class FooBloc extends Bloc<FooEvent, FooState> {
  FooBloc(this._repository) : super(const FooState.loading()) {
    on<FooLoadEvent>(_onLoad);
  }

  final FooRepository _repository;

  Future<void> _onLoad(FooLoadEvent event, Emitter<FooState> emit) async {
    emit(const FooState.loading());
    final result = await _repository.getFoo(event.id);
    emit(result.fold(
      (failure) => FooState.error(failure: failure),
      (data)    => FooState.success(data: data),
    ));
  }
}
```

UI:

```dart
BlocBuilder<FooBloc, FooState>(
  builder: (context, state) {
    if (state is FooLoadingState) return const LoadingContent();
    if (state is FooErrorState)   return ErrorContent(onTryAgainClick: ...);
    if (state is FooSuccessState) return FooView(data: state.data);
    return const SizedBox.shrink();
  },
)
```

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
rest automatically. Do not hand-pick palette swatches.

User preference is stored as the `AppTheme` enum (`system` / `light` / `dark`)
via `ThemeCubit` → `ThemeRepository` → `SharedPreferencesThemeStorage`.

---

## What NOT to do

- ❌ Don't introduce other state-management libraries (no Provider-only, no Riverpod) — use Bloc/Cubit.
- ❌ Don't call retrofit services or `Dio` from blocs or screens.
- ❌ Don't throw exceptions across layer boundaries — return `Left(Failure(...))`.
- ❌ Don't use raw route strings — use `AppRoutes` constants.
- ❌ Don't put business logic in `index.dart` — it is a barrel re-exports file only.
- ❌ Don't extend the launch feature — treat it as a *read-only pattern reference*.

---

## Reference: existing launch feature

The launch feature is the canonical example of every pattern in this template:

| File | Shows |
|------|-------|
| `lib/data/network/service/launch/launch_service.dart` | retrofit `@RestApi()` |
| `lib/data/network/data_source/launches_network_data_source.dart` | DataSource impl |
| `lib/repository/launches_repository.dart` | Repository + `Result<T>` |
| `lib/features/launch/bloc/launch_bloc.dart` | Bloc + freezed states |
| `lib/features/launch/view/launch_screen.dart` | BlocBuilder + state pattern |

When adding a new feature, copy this structure — don't modify these files.
