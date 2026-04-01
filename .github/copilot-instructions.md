# Flutter BLoC Template - AI Instructions

This document guides AI code generation and suggestions to maintain consistency with this template's architecture, patterns, and code style. Follow these guidelines when generating or suggesting new code.

---

## 📋 Project Overview

This is a **Flutter BLoC App Template** designed as a reusable foundation for building scalable Flutter applications. It emphasizes:
- Clean Architecture (BLoC pattern for state management)
- Dependency Injection using GetIt & Injectable
- Type-safe networking with Retrofit & Dio
- Functional error handling with Dartz
- Multi-flavor support (dev, qa, prod)
- Comprehensive logging with Talker
- Localization and Theme support

### ⚠️ Important Note
The **`launch`** feature in `lib/features/` is provided as an **example/reference implementation only**. 

When building new screens or converting Figma designs to UI:
- **DO NOT copy or extend** the launch feature
- Use the launch feature as a **pattern reference** to understand the architecture
- Create your own feature folders following the same structure
- This ensures clean separation of template example code from your application code

---

## 🛠 Technology Stack

### Core Dependencies
- **flutter_bloc** - State management and architecture
- **get_it** - Service locator for dependency injection
- **injectable** - DI code generation
- **freezed** - Code generation for immutable models
- **retrofit** - Type-safe HTTP client generator
- **dio** - HTTP client
- **dartz** - Functional programming (Either type)
- **equatable** - Value equality for models
- **talker** - Comprehensive logging
- **shared_preferences** - Local storage
- **intl** - Internationalization (i18n)
- **provider** - Additional state management support
- **google_fonts** - Font management

### Code Generation Dependencies
- **flutter_gen_runner** - Asset, font, and localization generation
- **json_serializable** - JSON serialization
- **retrofit_generator** - API client generation
- **injectable_generator** - DI setup generation
- **build_runner** - Build system

---

## 📁 Project Structure

```
lib/
├── app/                      # App widget and configuration
│   ├── app.dart             # Root App widget
│   └── [feature_specific]/   # Feature-specific widgets
├── features/                 # Feature modules
│   ├── [feature_name]/
│   │   ├── bloc/            # BLoC state management
│   │   ├── data/            # Data layer (repositories, data sources)
│   │   ├── models/          # Feature-specific models
│   │   ├── widgets/         # Feature UI components
│   │   └── [feature_screen].dart  # Main screen/page
├── bloc/                     # Global/app-level BLoCs
│   └── [bloc_name]/
├── data/                     # Shared data layer
│   ├── network/             # API clients and networking
│   └── [shared_data]/
├── models/                   # Shared domain models
├── repository/              # Repository implementations
├── di/                       # Dependency Injection setup
│   ├── di_container.dart
│   ├── di_initializer.dart
│   └── di_*_module.dart     # Feature modules
├── routes/                   # Navigation routing
├── theme/                    # Theme configuration
├── utils/                    # Utility functions
├── widgets/                  # Shared/global widgets
├── l10n/                     # Localization files
├── config/                   # App configuration
├── constants/                # App constants
└── generated/               # Generated code (assets, localization, etc.)
```

---

## 🎨 Code Style & Formatting

### Dart Format Rules
- Run `dart format .` before committing
- Maximum line length: **80 characters** (enforced in analysis_options.yaml)
- Use trailing commas in multi-line structures
- Use single quotes for strings (except where unavoidable)

### Linting Rules
The project uses strict linting via `analysis_options.yaml`:
- **Always declare return types** on functions and methods
- **Prefer const constructors** when possible
- **Prefer final fields** instead of getters
- **Use camelCase** for variable/method names
- **Use PascalCase** for class names
- **Avoid null checks in equality operators**
- **Lines must be ≤80 characters**

### Run Analysis
```bash
# Check for linting and analysis errors
make check

# Or manually
dart analyze

# Auto-format code
make format
# Or
dart format lib/
```

---

## 🏗 Architecture Patterns

### Clean Architecture Layers

1. **Presentation Layer** (UI/BLoC)
   - Widgets, screens, and BLoCs
   - Located in `lib/features/[feature]/` and `lib/bloc/`
   - Handles UI state, user interactions

2. **Domain Layer** (Repositories & Models)
   - Abstractions for data access
   - Models and entities
   - Located in `lib/repository/` and `lib/models/`

3. **Data Layer** (Data Sources & API)
   - Network clients, local storage, API calls
   - Located in `lib/data/`
   - Implements repository interfaces

### BLoC Pattern Structure

Every feature should follow this BLoC organization:

```
features/[feature_name]/
├── bloc/
│   ├── [feature]_bloc.dart         # Main BLoC class
│   ├── [feature]_event.dart        # Events (Freezed)
│   └── [feature]_state.dart        # States (Freezed)
├── data/
│   ├── models/
│   │   └── [model]_model.dart      # Freezed @JsonSerializable models
│   └── [feature]_data_source.dart  # Network/local data source
├── widgets/
│   └── [component_name].dart       # Reusable widgets
└── [feature]_screen.dart           # Main screen/page
```

---

## 📦 BLoC Implementation Guidelines

### State Definition (Freezed)
Always use **Freezed** for immutable state classes:

```dart
// lib/features/[feature]/bloc/[feature]_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '[feature]_state.freezed.dart';

@freezed
class [Feature]State with _$[Feature]State {
  const factory [Feature]State.initial() = _Initial;
  const factory [Feature]State.loading() = _Loading;
  const factory [Feature]State.success({required List<T> data}) = _Success;
  const factory [Feature]State.error({required String message}) = _Error;
}
```

### Event Definition (Freezed)
Events should be Freezed classes:

```dart
// lib/features/[feature]/bloc/[feature]_event.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '[feature]_event.freezed.dart';

@freezed
class [Feature]Event with _$[Feature]Event {
  const factory [Feature]Event.fetch({
    int? limit,
    int? offset,
  }) = _Fetch;
  const factory [Feature]Event.refresh() = _Refresh;
}
```

### BLoC Class Implementation
```dart
// lib/features/[feature]/bloc/[feature]_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

class [Feature]Bloc extends Bloc<[Feature]Event, [Feature]State> {
  [Feature]Bloc(this._repository) : super(const [Feature]State.initial()) {
    on<[Feature]Event>(_onFetch);
    on<[Feature]RefreshEvent>(_onRefresh);
  }

  final [Feature]Repository _repository;

  Future<void> _onFetch(
    [Feature]FetchEvent event,
    Emitter<[Feature]State> emit,
  ) async {
    emit(const [Feature]State.loading());
    try {
      final data = await _repository.fetch(
        limit: event.limit,
        offset: event.offset,
      );
      emit([Feature]State.success(data: data));
    } catch (e) {
      emit([Feature]State.error(message: e.toString()));
    }
  }

  Future<void> _onRefresh(
    [Feature]RefreshEvent event,
    Emitter<[Feature]State> emit,
  ) async {
    await _onFetch(
      [Feature]FetchEvent(),
      emit,
    );
  }
}
```

---

## 💉 Dependency Injection (GetIt & Injectable)

### Service Locator (GetIt)
GetIt is used for all dependency injection. Access it globally:

```dart
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

// Access dependencies
final myRepository = getIt<MyRepository>();
```

### Injectable Annotations
Use **Injectable** for automatic DI registration:

```dart
import 'package:injectable/injectable.dart';

// For singletons (single instance for app lifetime)
@singleton
class MyService {
  // ...
}

// For lazy singletons (created on first use)
@lazySingleton
class MyRepository {
  // ...
}

// For factories (new instance every time)
@injectable
class MyUseCase {
  MyUseCase(MyRepository repository);
}

// Environment-specific registration
@dev
class DevApiClient extends ApiClient {
  // ...
}

@prod
class ProdApiClient extends ApiClient {
  // ...
}
```

### DI Module Structure
Create feature-specific DI modules:

```dart
// lib/di/di_[feature]_module.dart
import 'package:injectable/injectable.dart';

@module
abstract class [Feature]Module {
  @lazySingleton
  [Feature]Repository get [feature]Repository => [Feature]RepositoryImpl(
        dataSource: getIt<[Feature]DataSource>(),
      );

  @lazySingleton
  [Feature]DataSource get [feature]DataSource => [Feature]DataSourceImpl(
        client: getIt<Dio>(),
      );
}
```

### Register Module in DI Initializer
```dart
// lib/di/di_initializer.dart
@injectableInit
Future<GetIt> initDI(GetIt getIt, String environment) async {
  registerDependencies();
  await getIt.isReady<SharedPreferences>();
  return getIt.init(environment: environment);
}
```

---

## 📡 Data Layer & Repositories

### Repository Pattern
Repositories act as intermediaries between BLoC and data sources. Always use abstract classes:

```dart
// lib/repository/[feature]_repository.dart
abstract class [Feature]Repository {
  Future<List<[Model]>> fetch({int? limit, int? offset});
  Future<[Model]> getById(String id);
}

class [Feature]RepositoryImpl implements [Feature]Repository {
  [Feature]RepositoryImpl(this._dataSource);

  final [Feature]DataSource _dataSource;

  @override
  Future<List<[Model]>> fetch({int? limit, int? offset}) async {
    final result = await _dataSource.fetch(limit: limit, offset: offset);
    return result.map((e) => e.toResource()).toList();
  }
}
```

### API Client (Retrofit)
Use **Retrofit** for type-safe HTTP clients:

```dart
// lib/data/network/api/[feature]_api_client.dart
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part '[feature]_api_client.g.dart';

@RestApi(baseUrl: 'https://api.example.com')
abstract class [Feature]ApiClient {
  factory [Feature]ApiClient(Dio dio, {String baseUrl}) = _[Feature]ApiClient;

  @GET('/[endpoint]')
  Future<List<[Model]Dto>> fetch(
    @Query('limit') int limit,
    @Query('offset') int offset,
  );

  @GET('/[endpoint]/{id}')
  Future<[Model]Dto> getById(@Path('id') String id);
}
```

### Data Models with Freezed & JSON
Always use **Freezed** for JSON models:

```dart
// lib/features/[feature]/data/models/[model]_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '[model]_model.freezed.dart';
part '[model]_model.g.dart';

@freezed
class [Model]Model with _$[Model]Model {
  const factory [Model]Model({
    required String id,
    required String name,
    @Default(0) int count,
  }) = _[Model]Model;

  factory [Model]Model.fromJson(Map<String, dynamic> json) =>
      _$[Model]ModelFromJson(json);
}
```

---

## 🎯 UI/Presentation Layer

### Screens & Pages
Main screens should extend `StatelessWidget` and use `BlocBuilder`:

```dart
// lib/features/[feature]/[feature]_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class [Feature]Screen extends StatelessWidget {
  const [Feature]Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<[Feature]Bloc, [Feature]State>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          success: (data) => _buildContent(context, data),
          error: (message) => Center(child: Text('Error: $message')),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, List<T> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => _buildItem(data[index]),
    );
  }

  Widget _buildItem(T item) {
    // UI for item
    return const SizedBox();
  }
}
```

### Widgets & Components
Create reusable widgets in the `widgets/` directory:

```dart
// lib/features/[feature]/widgets/[component].dart
import 'package:flutter/material.dart';

class [Component]Widget extends StatelessWidget {
  const [Component]Widget({
    super.key,
    required this.data,
  });

  final T data;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Widget implementation
    );
  }
}
```

### Accessing BLoC
Use named constructors for cleaner BLoC access:

```dart
// In a screen
context.read<[Feature]Bloc>().add(const [Feature]Event.fetch());

// In a widget listener
BlocListener<[Feature]Bloc, [Feature]State>(
  listener: (context, state) {
    state.whenOrNull(
      success: (data) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Success!')),
      ),
    );
  },
  child: const SizedBox(),
);
```

---

## 📦 State Management Best Practices

### Multi-Repository BLoC
When a BLoC needs multiple repositories:

```dart
class ComplexBloc extends Bloc<ComplexEvent, ComplexState> {
  ComplexBloc({
    required Repository1 repo1,
    required Repository2 repo2,
  })  : _repo1 = repo1,
        _repo2 = repo2,
        super(const ComplexState.initial()) {
    on<ComplexEvent>(_onEvent);
  }

  final Repository1 _repo1;
  final Repository2 _repo2;

  Future<void> _onEvent(
    ComplexEvent event,
    Emitter<ComplexState> emit,
  ) async {
    emit(const ComplexState.loading());
    try {
      final result1 = await _repo1.fetch();
      final result2 = await _repo2.fetch();
      emit(ComplexState.success(data: result1 + result2));
    } catch (e) {
      emit(ComplexState.error(message: e.toString()));
    }
  }
}
```

### Error Handling with Dartz
Use **Dartz Either** for functional error handling:

```dart
import 'package:dartz/dartz.dart';

// Repository method
Future<Either<Failure, List<T>>> fetch() async {
  try {
    final data = await _dataSource.fetch();
    return Right(data);
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}

// In BLoC
Future<void> _onFetch(FetchEvent event, Emitter<State> emit) async {
  emit(const State.loading());
  final result = await _repository.fetch();
  result.fold(
    (failure) => emit(State.error(message: failure.message)),
    (data) => emit(State.success(data: data)),
  );
}
```

---

## ✅ Testing Guidelines

### Unit Tests for BLoCs
```dart
// test/features/[feature]/bloc/[feature]_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late [Feature]Bloc [feature]Bloc;
  late Mock[Feature]Repository mock[Feature]Repository;

  setUp(() {
    mock[Feature]Repository = Mock[Feature]Repository();
    [feature]Bloc = [Feature]Bloc(mock[Feature]Repository);
  });

  tearDown(() => [feature]Bloc.close());

  group('[Feature]Bloc', () {
    test('initial state is [Feature]State.initial()', () {
      expect([feature]Bloc.state, equals(const [Feature]State.initial()));
    });

    blocTest<[Feature]Bloc, [Feature]State>(
      'emits [loading, success] when fetch succeeds',
      setUp: () {
        when(() => mock[Feature]Repository.fetch()).thenAnswer(
          (_) async => [testModel],
        );
      },
      build: () => [feature]Bloc,
      act: (bloc) => bloc.add(const [Feature]Event.fetch()),
      expect: () => [
        const [Feature]State.loading(),
        [Feature]State.success(data: [testModel]),
      ],
    );

    blocTest<[Feature]Bloc, [Feature]State>(
      'emits [loading, error] when fetch fails',
      setUp: () {
        when(() => mock[Feature]Repository.fetch()).thenThrow(Exception());
      },
      build: () => [feature]Bloc,
      act: (bloc) => bloc.add(const [Feature]Event.fetch()),
      expect: () => [
        const [Feature]State.loading(),
        isA<[Feature]StateError>(),
      ],
    );
  });
}
```

### Widget Tests
```dart
// test/features/[feature]/[feature]_screen_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late Mock[Feature]Bloc mock[Feature]Bloc;

  setUp(() {
    mock[Feature]Bloc = Mock[Feature]Bloc();
  });

  testWidgets('[Feature]Screen displays data', (WidgetTester tester) async {
    when(() => mock[Feature]Bloc.state)
        .thenReturn([Feature]State.success(data: testData));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<[Feature]Bloc>.value(
          value: mock[Feature]Bloc,
          child: const [Feature]Screen(),
        ),
      ),
    );

    expect(find.byType(ListView), findsOneWidget);
  });
}
```

---

## 🔧 Code Generation Commands

### Generate All
```bash
make gen
```

This runs:
- FlutterGen (assets, fonts, localization)
- Freezed code generation
- Injectable DI setup generation
- Retrofit API client generation
- JSON serialization generation

### Manual Generation Commands
```bash
# Generate localization only
make localize

# Run build_runner
dart run build_runner build --delete-conflicting-outputs

# Watch for changes
dart run build_runner watch
```

---

## 📝 Naming Conventions

### Files & Directories
- Use **snake_case** for file names: `my_feature_bloc.dart`
- Use **snake_case** for directory names: `lib/features/my_feature/`
- Suffix files with their type: `_bloc.dart`, `_state.dart`, `_event.dart`, `_screen.dart`, etc.

### Classes & Types
- Use **PascalCase** for class names: `MyFeatureBloc`, `MyState`, `MyEvent`
- Use **PascalCase** for enums: `MyEnum`
- Use **PascalCase** for typedefs: `MyCallback`

### Variables & Functions
- Use **camelCase** for variables and functions: `myVariable`, `myFunction()`
- Use **SCREAMING_SNAKE_CASE** for constants: `const MY_CONSTANT = 42;`
- Private members: prefix with underscore `_privateVar`

### BLoC Naming
- Bloc: `[Feature]Bloc` e.g., `LaunchesBloc`
- Events: `[Feature]Event` e.g., `LaunchesEvent`, `FetchLaunchesEvent`
- States: `[Feature]State` e.g., `LaunchesState`
- Repositories: `[Feature]Repository`, `[Feature]RepositoryImpl`
- Data Sources: `[Feature]DataSource`, `[Feature]ApiClient`

---

## 🎯 Common Patterns

### Loading Pagination
```dart
class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  PaginationBloc(this._repository) : super(const PaginationState.initial()) {
    on<FetchPageEvent>(_onFetchPage);
    on<LoadMoreEvent>(_onLoadMore);
  }

  final Repository _repository;
  int _currentPage = 0;

  Future<void> _onFetchPage(
    FetchPageEvent event,
    Emitter<PaginationState> emit,
  ) async {
    emit(const PaginationState.loading());
    _currentPage = 0;
    try {
      final data = await _repository.fetch(page: _currentPage);
      emit(PaginationState.success(data: data, hasMore: data.length >= 20));
    } catch (e) {
      emit(PaginationState.error(message: e.toString()));
    }
  }

  Future<void> _onLoadMore(
    LoadMoreEvent event,
    Emitter<PaginationState> emit,
  ) async {
    final currentState = state;
    if (currentState is! PaginationStateSuccess) return;

    _currentPage++;
    try {
      final newData = await _repository.fetch(page: _currentPage);
      final allData = [...currentState.data, ...newData];
      emit(PaginationState.success(
        data: allData,
        hasMore: newData.length >= 20,
      ));
    } catch (e) {
      _currentPage--;
      emit(PaginationState.error(message: e.toString()));
    }
  }
}
```

### Multi-Event Handling
```dart
class MultiEventBloc extends Bloc<MyEvent, MyState> {
  MultiEventBloc(this._repo) : super(const MyState.initial()) {
    on<FetchEvent>(_onFetch);
    on<RefreshEvent>(_onRefresh);
    on<DeleteEvent>(_onDelete);
  }

  final Repository _repo;

  Future<void> _onFetch(FetchEvent event, Emitter<MyState> emit) async {
    // Implementation
  }

  Future<void> _onRefresh(RefreshEvent event, Emitter<MyState> emit) async {
    // Implementation (can reuse _onFetch logic)
    await _onFetch(FetchEvent(), emit);
  }

  Future<void> _onDelete(DeleteEvent event, Emitter<MyState> emit) async {
    // Implementation
  }
}
```

---

## 🚀 Best Practices Checklist

When adding new features or UI:

- [ ] Create feature directory under `lib/features/[feature_name]/`
- [ ] Use Freezed for all immutable classes (models, events, states)
- [ ] Create abstract repository and concrete implementation
- [ ] Use `@injectable` and `@lazySingleton` annotations for DI
- [ ] Implement BLoC with event handlers for each action
- [ ] Use `BlocBuilder` for UI updates
- [ ] Use `BlocListener` for side effects (navigation, snackbars)
- [ ] Follow the 80-character line limit
- [ ] Use trailing commas in multi-line structures
- [ ] Always declare return types
- [ ] Prefer `const` constructors
- [ ] Use `context.read<>()` for one-off actions
- [ ] Use `context.watch<>()` in widgets that need live updates
- [ ] Write unit tests for BLoCs
- [ ] Write widget tests for screens
- [ ] Run `make check` before committing
- [ ] Run `make gen` after changes requiring code generation
- [ ] Keep BLoC logic simple; delegate complexity to repositories
- [ ] Use meaningful variable and function names
- [ ] Add comments for complex logic

---

## 🔗 Multi-Flavor Support

This template supports **dev**, **qa**, and **prod** flavors. When adding new features:

### Create Flavor-Specific Main Files (if needed)
```dart
// lib/main_dev.dart
void main(List<String> args) {
  Environment.init(
    buildType: BuildType.debug,
    config: AppConfig(url: 'https://dev-api.example.com'),
  );
  run();
}

// lib/main_prod.dart
void main(List<String> args) {
  Environment.init(
    buildType: BuildType.release,
    config: AppConfig(url: 'https://api.example.com'),
  );
  run();
}
```

### Environment-Specific Dependencies
```dart
@singleton
@dev
class DevLoggingService extends LoggingService {
  @override
  void log(String message) => print('[DEV] $message');
}

@singleton
@prod
class ProdLoggingService extends LoggingService {
  @override
  void log(String message) => talker.info(message);
}
```

---

## 🧪 Quality & Optimization

### Code Quality
- Maximum cyclomatic complexity: **20**
- Maximum nesting level: **5**
- Maximum method parameters: **4**
- Maximum source lines per function: **50**

Run static analysis:
```bash
make check
dart analyze
```

### Performance Tips
- Use `const` constructors wherever possible
- Avoid rebuilding large widgets unnecessarily
- Use `RepaintBoundary` for expensive UI updates
- Implement proper image caching (consider `cached_network_image`)
- Profile using `DevTools` for performance issues

---

## 📚 Additional Resources

- **BLoC Library**: https://bloclibrary.dev/
- **GetIt**: https://pub.dev/packages/get_it
- **Injectable**: https://pub.dev/packages/injectable
- **Freezed**: https://pub.dev/packages/freezed
- **Retrofit**: https://pub.dev/packages/retrofit
- **Dartz**: https://pub.dev/packages/dartz
- **Flutter Testing**: https://flutter.dev/docs/testing

---

## 🤖 Key Instructions for AI Assistants

When generating code, ALWAYS:

1. Use **Freezed** for all immutable models and classes
2. Implement cleaner `when()` pattern with`.when()` or `.whenOrNull()`
3. Follow the exact **file structure** specified above
4. Use **BlocBuilder** and **BlocListener** for UI updates
5. Keep BLoC logic simple and delegate to repositories
6. Use abstract repositories with concrete implementations
7. Add **@injectable** and **@lazySingleton** annotations
8. Declare **all return types** explicitly
9. Respect the **80-character line limit**
10. Use **trailing commas** in multi-line structures
11. Write **unit and widget tests** for new features
12. Follow the **naming conventions** strictly
13. Run `make gen` when adding code generation classes
14. Run `make check` to validate code quality

---

**Last Updated**: April 2026  
**Template Version**: 1.0.0
