/// Generates a comprehensive, human-friendly and AI-agent-friendly README.md
/// tailored specifically for a newly generated Flutter project.
String generateProjectReadme({
  required String projectName,
  required String packageName,
  required String appTitle,
}) {
  return '''# $appTitle (`$projectName`)

A modern, production-ready Flutter application built with **BLoC pattern**, **Clean Architecture**, **Material 3**, and **AI Agent MCP Toolkit** integration.

- **Package / Application ID**: `$packageName`
- **Dart Package**: `$projectName`

---

## Table of Contents

- [Quick Start & Flavors](#quick-start--flavors)
- [Architecture & Directory Structure](#architecture--directory-structure)
- [Core Workflow: Screenshot-to-Code UI First, then API Backend](#core-workflow-screenshot-to-code-ui-first-then-api-backend)
  - [Phase 1: UI Implementation from Screenshots / Mockups](#phase-1-ui-implementation-from-screenshots--mockups)
  - [Phase 2: API Backend Integration (9-Step Sequence)](#phase-2-api-backend-integration-9-step-sequence)
- [AI Agent Integration (Antigravity, Codex, Claude, Cursor, Gemini)](#ai-agent-integration)
- [Flutter MCP Toolkit Workflow](#flutter-mcp-toolkit-workflow)
- [Common Commands & Code Generation](#common-commands--code-generation)
- [Design Tokens, Theming & Localization](#design-tokens-theming--localization)
- [Quality & Engineering Rules](#quality--engineering-rules)

---

## Quick Start & Flavors

### Prerequisites
- **Flutter SDK**: `>=3.11.4` (channel stable)
- **Dart SDK**: `>=3.11.4`

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run Code Generation
```bash
dart run build_runner build --delete-conflicting-outputs
flutter pub run intl_utils:generate
```

### 3. Run With Flavors
This project comes preconfigured with three distinct environment flavors (`dev`, `qa`, `prod`):

```bash
# Development (default API environment, talker logs, debug banner)
flutter run -t lib/main_dev.dart --flavor dev

# QA / Staging
flutter run -t lib/main_qa.dart --flavor qa

# Production
flutter run -t lib/main_prod.dart --flavor prod
```

> Launch configurations for VS Code (`.vscode/launch.json`) and Android Studio / IntelliJ are preconfigured for all three flavors.

---

## Architecture & Directory Structure

This project follows **Clean Architecture** with feature vertical slices:

```text
lib/
├── app/                         # App shell, lifecycle observer, global error handling, MCP tools
│   ├── app.dart
│   ├── app_runner.dart          # Entrypoint runner (DI init, Talker logger, MCP binding)
│   └── agent_mcp_tools.dart     # In-app custom MCP tools for AI agents
├── bloc/theme/                  # Global ThemeCubit and theme mode persistence
├── config/                      # Environment configs (dev, qa, prod), feature flags, build types
├── constants/                   # Shared constant values, icon aliases
├── data/
│   ├── failure/                 # Failure hierarchy and Dio error mapper (NetworkFailure, CacheFailure, etc.)
│   └── network/
│       ├── converter/           # Shared JSON converters
│       ├── data_source/         # Network data sources (catches errors, returns Result<T>)
│       ├── interceptors/        # Connectivity, retry, talker logging interceptors
│       ├── model/               # Network DTOs (@JsonSerializable)
│       └── service/             # Retrofit REST API clients (@RestApi)
├── di/                          # Dependency injection modules (Injectable + GetIt)
│   ├── app_bloc_providers.dart  # Global bloc providers (only for app-wide blocs)
│   ├── app_repository_providers.dart # Repository providers exposed to the widget tree
│   ├── di_network_module.dart   # Retrofit services & data source bindings
│   └── di_repository_module.dart# Domain repository bindings
├── features/                    # Feature vertical slices
│   ├── home/                    # Initial starter screen
│   ├── settings/                # Theme and app settings
│   └── <feature_name>/          # Real feature slices
│       ├── bloc/                # Feature-specific Bloc/Cubit, Events, States
│       ├── view/                # Main screen layout (<name>_screen.dart)
│       ├── widget/              # Feature-private UI widgets
│       └── model/               # Feature UI view models (if any)
├── l10n/                        # Localization ARB files (app_en.arb, intl_en.arb)
├── models/                      # Domain resources & entity models (clean, immutable)
├── repository/                  # Domain repository interfaces & implementations (returns Result<T>)
├── routes/                      # GoRouter routing declarations and path constants
├── theme/                       # Material 3 theme configuration, color schemes, typography tokens
├── utils/                       # General helper utilities
└── widgets/                     # Shared cross-feature UI widgets (loaders, empty states, error banners)
```

---

## Core Workflow: Screenshot-to-Code UI First, then API Backend

To ensure rapid iteration, clean separation of concerns, and pixel-accurate visual design, this project enforces a two-phase development methodology:

```text
[ Reference Screenshot / Mockup ]
              │
              ▼
   ┌─────────────────────────────────────────────────────────┐
   │ PHASE 1: Screenshot-Driven UI First                     │
   │ - Create vertical slice: lib/features/<feature>/         │
   │ - Build screen & widgets from screenshot                │
   │ - Use mock/dummy data in Bloc state                     │
   │ - Place text in ARB (l10n) & colors in theme            │
   │ - Visual perfection loop via Flutter MCP Toolkit        │
   └─────────────────────────────────────────────────────────┘
              │
              ▼ (UI is pixel-verified & signed off)
   ┌─────────────────────────────────────────────────────────┐
   │ PHASE 2: API Backend Integration (Strict 9 Steps)       │
   │ 1. Network DTO          2. Retrofit Service             │
   │ 3. Network Data Source  4. Domain Resource              │
   │ 5. Extension Mapper     6. Domain Repository            │
   │ 7. Network DI           8. Repository DI                │
   │ 9. App Providers -> Connect to Bloc                     │
   └─────────────────────────────────────────────────────────┘
```

---

### Phase 1: UI Implementation from Screenshots / Mockups

When given a mockup or reference screenshot, **implement the complete visual UI first before introducing any networking or API calls**:

1. **Create the Feature Vertical Slice**:
   ```text
   lib/features/<name>/
     ├── bloc/
     │   ├── <name>_bloc.dart
     │   ├── <name>_event.dart
     │   └── <name>_state.dart
     ├── view/
     │   └── <name>_screen.dart
     └── widget/
         └── <name>_card.dart (and other feature-specific components)
   ```

2. **Decouple from Backend using Mock Bloc State**:
   - Write the BLoC/Cubit to emit mock or dummy data simulating all UI states:
     - `Initial` / `Loading`
     - `Success` (populated with realistic mock content matching the reference screenshot)
     - `Empty` state
     - `Error` state

3. **No Hardcoded Strings**:
   - Place all user-visible strings into `lib/l10n/intl_en.arb`.
   - Run `flutter gen-l10n` or `flutter pub run intl_utils:generate`.
   - Access strings in widgets via `S.of(context).keyName` or `context.l10n.keyName`.

4. **Design Tokens & Theme Access**:
   - Use Material 3 tokens from `Theme.of(context).colorScheme` and `Theme.of(context).textTheme`.
   - Never scatter raw hexadecimal color literals throughout feature widgets.
   - Adjust theme seed or add domain styling tokens in `lib/theme/` if needed.

5. **Component Placement Rules**:
   - Shared components (buttons, input fields, cards used across multiple screens) belong in `lib/widgets/`.
   - Feature-only components belong in `lib/features/<name>/widget/`.
   - The primary screen layout belongs in `lib/features/<name>/view/<name>_screen.dart`.

6. **Route Registration**:
   - Register the route in `lib/routes/router.dart` using a typed route constant in `AppRoutes`.

---

### Phase 2: API Backend Integration (9-Step Sequence)

Once the UI layout and states are verified against the screenshot, connect the real backend following this strict 9-step sequence:

| Step | Layer | File Path | Responsibilities |
|---|---|---|---|
| **1** | **Network DTO** | `lib/data/network/model/<feature>/network_<feature>_model.dart` | `@JsonSerializable()` model matching the API response JSON structure. |
| **2** | **Retrofit Service** | `lib/data/network/service/<feature>/<feature>_service.dart` | `@RestApi()` contract defining HTTP methods (`@GET`, `@POST`, etc.). |
| **3** | **Network Data Source** | `lib/data/network/data_source/<feature>_network_data_source.dart` | Executes service calls, catches exceptions, and returns `Result<T>` (`dartz` `Either<Failure, T>`). |
| **4** | **Domain Resource** | `lib/models/<feature>/<feature>_resource.dart` | Pure, immutable business entity consumed by Blocs and UI. |
| **5** | **Extension Mapper** | `lib/models/<feature>/<feature>_ext.dart` | Extension methods converting `Network*Model` DTOs into Domain resources (`model.toResource()`). |
| **6** | **Repository** | `lib/repository/<feature>_repository.dart` | Domain interface and implementation returning `Result<DomainResource>`. |
| **7** | **Network DI** | `lib/di/di_network_module.dart` | Register the Retrofit service and Network Data Source with `@singleton` or `@injectable`. |
| **8** | **Repository DI** | `lib/di/di_repository_module.dart` | Register the Repository implementation with `@LazySingleton(as: <Feature>Repository)`. |
| **9** | **App Providers** | `lib/di/app_repository_providers.dart` | Expose the repository to the widget tree via `RepositoryProvider` (if needed globally) and wire into the feature Bloc. |

#### Crucial API Architecture Rules:
- **Never call Dio, Retrofit, or HTTP directly from UI widgets or Blocs.**
- **Never use `try/catch` inside Blocs.** Data sources catch exceptions and return `Result<T>` (`Either<Failure, T>`).
- Blocs simply fold the `Result`:
  ```dart
  final result = await _repository.fetchDetails(event.id);
  emit(
    result.fold(
      (failure) => FeatureState.error(message: failure.message),
      (data) => FeatureState.success(data: data),
    ),
  );
  ```
- Run code generation immediately after adding models or DI:
  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```

---

## AI Agent Integration

This codebase is pre-equipped with instructions and configurations for autonomous AI agents:

| AI Assistant | Instruction File / Config | Description |
|---|---|---|
| **Antigravity** | `AGENTS.md`, `mcp.json`, `.agents/skills/` | Preconfigured with Flutter MCP skills for live UI inspection, visual diffing, and control. |
| **Claude / Claude Code** | `CLAUDE.md`, `.agents/` | Complete architectural rules, BLoC guidelines, and 9-step API flow. |
| **Codex** | `CODEX.md` | Run `flutter-mcp-toolkit init codex` to bind tools. |
| **Cursor / Windsurf** | `.cursor/`, `mcp.json` | MCP server discovery and editor rule integration. |
| **Gemini** | `GEMINI.md` | Full reference-image-driven guidelines. |
| **GitHub Copilot** | `.github/copilot-instructions.md` | Contextual prompt instructions. |

### How to Prompt Your AI Agent

#### 1. For Implementing UI from a Screenshot:
> *"Here is a screenshot of the new [Feature Name] screen. Follow the Screenshot-Driven UI First workflow: create a vertical slice in `lib/features/<name>`, implement the layout and feature widgets, use mock Bloc state with all UI states, place text in ARB files, and use the Flutter MCP Toolkit to visually verify the live screen against the screenshot."*

#### 2. For Connecting the Backend API:
> *"The UI for [Feature Name] is complete. Now follow the 9-Step API Backend Integration sequence to implement the Network DTO, Retrofit Service, Data Source, Domain Resource, Mapper, Repository, and DI modules, then connect it to the feature Bloc."*

---

## Flutter MCP Toolkit Workflow

The app includes out-of-the-box support for the [Flutter MCP Toolkit](https://github.com/Arenukvern/mcp_flutter) (`mcp_toolkit`).

### Visual QA Loop for AI Agents:
1. **Start the app**:
   ```bash
   flutter run -t lib/main_dev.dart --flavor dev
   ```
2. **AI Agent captures live UI**:
   The agent calls `fmt_get_screenshots` or `fmt_capture_ui_snapshot`.
3. **Inspect semantic layout**:
   The agent calls `fmt_semantic_snapshot` or `fmt_get_view_details` to verify widget boundaries.
4. **Compare & Refine**:
   The agent compares the live screenshot with the reference image, tweaks padding, typography, colors, or alignment in code, and triggers `fmt_hot_reload_flutter`.
5. **Zero Errors Guarantee**:
   The agent queries `fmt_get_app_errors` to verify no `RenderFlex` overflows or unhandled exceptions occurred.

---

## Common Commands & Code Generation

### Run Code Generation
```bash
# Clean build runner (models, DI, retrofit, freezed)
dart run build_runner build --delete-conflicting-outputs

# Watch mode during active development
dart run build_runner watch --delete-conflicting-outputs
```

### Localization Generation
```bash
flutter gen-l10n
flutter pub run intl_utils:generate
```

### Static Analysis & Testing
```bash
# Analyze codebase
flutter analyze

# Run unit and widget tests
flutter test

# Run tests with coverage
flutter test --coverage
```

---

## Design Tokens, Theming & Localization

- **Theme & Colors**:
  - Defined in `lib/theme/style.dart` and `lib/theme/theme.dart`.
  - Driven by a seed `ColorScheme` matching Material 3 specifications.
  - Supports automatic Light and Dark themes managed by `ThemeCubit`.
- **Localization**:
  - Source ARB files reside in `lib/l10n/`.
  - Add keys to `intl_en.arb` for English, and corresponding translations in other language ARBs.

---

## Quality & Engineering Rules

- **No Business Logic in Views**: UI widgets only dispatch Bloc events and render state.
- **No Direct HTTP in Blocs**: All networking is encapsulated in Data Sources and Repositories.
- **Result Monad**: Always return `Result<T>` (`Either<Failure, T>`) from Data Sources and Repositories. Never throw uncaught exceptions to Blocs.
- **Vertical Slice Independence**: Feature folders must remain self-contained. Shared components must be extracted to `lib/widgets/` or `lib/utils/`.
- **No Unused Imports / Clean Lints**: All code must pass `flutter analyze` with 0 warnings.
''';
}
