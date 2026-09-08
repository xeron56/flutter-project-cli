# AI Agent Guidelines & Workflow
# Reference-Image-Driven Flutter UI Implementation & Visual Perfection Skill

This document extends the base `.github/copilot-instructions.md` to provide detailed workflows for AI agents (Antigravity, Codex, Claude, Cursor, Windsurf, Gemini, etc.) working within this Flutter repository.

It defines exact procedures for UI-first implementation, API backend integration, and an iterative, vision-based UI perfection workflow using the Flutter MCP Toolkit.

This skill is designed to be reused every time the user provides one or more reference screenshots and asks the agent to:
- implement a missing Flutter UI from scratch,
- improve an existing Flutter UI,
- match an existing screen to a reference image,
- reproduce desktop, tablet, or mobile layouts,
- fix typography, spacing, colors, icons, logos, card sizes, borders, positions, responsiveness, and visual hierarchy,
- run the Flutter project,
- inspect the live application with Flutter MCP Toolkit,
- capture screenshots,
- compare the live result with the reference,
- modify the code repeatedly until the UI is visually equivalent to the reference.

The reference image is the primary visual source of truth unless the user explicitly says otherwise.

---

## 0. Core Mission

When a reference image is provided, the agent must act as a senior Flutter UI engineer and visual QA engineer.

The task is not complete when the screen merely "looks similar."

The task is complete only when:
1. The correct feature/screen exists.
2. The project builds successfully.
3. The target screen is reachable in the running app.
4. The layout matches the reference at the intended viewport size.
5. Typography, spacing, colors, borders, shadows, icons, logos, and component proportions are closely matched.
6. No Flutter layout/rendering/runtime errors are present.
7. Responsive behavior is implemented appropriately.
8. The agent has captured the current implementation screenshot.
9. The live screenshot has been compared against the reference image.
10. The agent has repeated the correction loop until no meaningful visual mismatch remains.

Do not stop after the first implementation pass.

Do not claim pixel-perfect or visually matched unless a screenshot comparison has actually been performed.

---

## 0.1 Non-Negotiable Rules

- Never blindly guess layout values when they can be measured or inferred from the reference image.
- Never hardcode user-facing strings directly in widgets.
- Never ignore an already-existing design system, theme, localization setup, routing structure, Bloc conventions, or reusable widgets.
- Never replace working architecture with a new architecture simply to implement one screen.
- Never create an unrelated landing page when the reference is clearly an application/dashboard/product screen.
- Never use random colors, arbitrary spacing, substitute fonts, placeholder icons, or placeholder logos when correct assets already exist in the repository.
- Never finish with visible overflow, clipped text, incorrect scroll behavior, broken states, or console/runtime errors.
- Never change unrelated features merely to make one screenshot match.
- Never hide a mismatch by cropping the screenshot.
- Never stretch or distort assets to imitate the reference.
- Never use `Transform.scale`, arbitrary negative offsets, or large stacks of magic numbers as the first solution to a structural layout problem.
- Prefer correct widget hierarchy, constraints, flex behavior, responsive breakpoints, and theme tokens.
- All changes must remain maintainable Flutter code.

---

## 0.2 Reference Image Priority

When multiple sources disagree, use this priority unless the user explicitly overrides it:

1. User's latest explicit instruction.
2. Latest reference screenshot for the target screen/state.
3. Existing project design system and assets.
4. Existing implementation behavior that is not contradicted by the reference.
5. General Material 3 defaults.

The reference image controls visual appearance.

The existing codebase controls architecture and engineering conventions.

---

## 0.3 Understand the Requested Target Before Editing

Before changing code, determine:

- Which image is the reference.
- Which image, if any, represents the current implementation.
- Whether the requested target is:
  - desktop,
  - mobile,
  - tablet,
  - responsive across multiple sizes.
- Approximate reference viewport dimensions/aspect ratio.
- Target route or screen.
- Required UI state:
  - selected tab,
  - open menu,
  - dialog,
  - populated list,
  - loading state,
  - empty state,
  - hover state,
  - error state,
  - success state.
- Whether the screen already exists in code.
- Whether the user wants only UI work or also backend/API wiring.

If the screen already exists, modify and improve it rather than creating a duplicate feature.

If the screen does not exist, implement it following the repository architecture.

---

# 1. UI Implementation First

When asked to implement a UI before the backend or API is ready, the agent must strictly adhere to the repository's structural patterns.

## 1.1 Where to Place UI Data

- **Text & Strings:** All user-facing text must be placed in `lib/l10n/` as ARB files (`app_en.arb`, etc.). Never hardcode strings directly in the UI widgets.

- **Fonts & Colors:** All styling tokens (fonts, colors, typography) must be integrated into `lib/theme/` (Material Theme/Brand Seed) or defined in `lib/constants/`. Use `Theme.of(context)` to access these values.

- **Common/Shared Widgets:** Generic UI components (buttons, text fields, cards, loaders) that will be used across multiple features should be placed in `lib/widgets/`.

- **Feature-Specific Widgets:** Widgets that belong only to a specific screen/feature must go into `lib/features/<name>/widget/`.

- **Screen View:** The main screen layout goes into `lib/features/<name>/view/<name>_screen.dart`.

## 1.2 Implementation Rules

- Create the feature as a vertical slice in `lib/features/<name>/`.

- Use `flutter_bloc` for state management, placing feature blocs in `lib/features/<name>/bloc/`.

- Use dummy or mock data inside the Bloc state temporarily, ensuring the UI accurately reflects all loading, error, empty, and success states.

- Do not build marketing landing pages; build the actual Flutter application flow.

---

# 1.3 Existing UI vs Missing UI Decision

Immediately inspect the repository and determine whether the requested screen already exists.

### Case A: The screen does not exist

Implement the screen from scratch.

Required sequence:
1. Locate routing/navigation architecture.
2. Locate existing application shell/layout.
3. Locate theme, typography, colors, spacing constants, icons, and assets.
4. Locate similar existing screens/components.
5. Create the feature vertical slice.
6. Add localization keys.
7. Add Bloc/state with mock data when backend is unavailable.
8. Add/reuse shared widgets.
9. Connect the screen to routing if required.
10. Render the target state.
11. Start the visual comparison loop.

### Case B: The screen already exists

Do not rewrite it automatically.

Required sequence:
1. Locate the current screen file.
2. Locate all widgets used by that screen.
3. Identify reusable theme/assets already being used.
4. Run the application and capture the current screen.
5. Compare current screenshot to reference.
6. Build a mismatch list.
7. Fix highest-impact structural differences first.
8. Re-run and re-capture.
9. Continue until matched.

---

# 1.4 Reference Screenshot Decomposition

Before writing layout code, visually decompose the reference into measurable regions.

For each screenshot, identify:

### Global structure
- viewport width and height,
- app background color,
- navigation/sidebar width,
- top bar height,
- main content max width,
- horizontal/vertical gutters,
- right panel width,
- major column ratios,
- scrollable vs fixed regions.

### Typography
For each distinct text style estimate:
- font family,
- font size,
- font weight,
- line height,
- letter spacing,
- foreground color,
- alignment,
- maximum lines,
- truncation behavior.

### Components
Measure or infer:
- card width/height,
- border radius,
- border thickness,
- shadow softness,
- icon container size,
- button size,
- input height,
- tab/pill height,
- toggle size,
- row spacing,
- separator thickness.

### Icons and logos
Determine whether each visual is:
- project asset,
- SVG,
- PNG/WebP,
- Material icon,
- Cupertino icon,
- custom icon font,
- package icon,
- brand logo.

Search the repository before approximating an icon/logo.

### Color roles
Identify:
- primary action color,
- selected navigation color,
- sidebar/background color,
- surface/card color,
- page background,
- text primary,
- text secondary,
- border,
- success,
- warning,
- error,
- disabled,
- badge colors.

Do not scatter raw color literals throughout widgets.

---

# 1.5 Assets, Logos, Icons, and Fonts

The visual match depends heavily on using the correct assets.

Before creating substitutes, search:

- `assets/`
- `lib/assets/`
- `images/`
- `icons/`
- `fonts/`
- `pubspec.yaml`
- theme files
- existing widgets/screens

### Logos
If the correct logo exists:
- use it,
- preserve its aspect ratio,
- match the displayed width/height from the reference,
- use the correct dark/light variant.

If the reference logo does not exist:
- check whether it can be recreated from already-available vector/icon assets,
- only create a new asset if the repository/task permits it,
- do not use an unrelated placeholder.

### Fonts
Check `pubspec.yaml` and theme configuration before selecting fonts.

If the reference appears to use a font already bundled in the repository, use that exact font.

If the exact font is unavailable:
1. use the closest project-approved font,
2. match weight, size, line-height, and letter spacing as closely as possible,
3. do not silently add an external font dependency unless appropriate for the repository.

### Icons
Prefer exact project assets or matching icon packages.

Do not use an obviously different Material icon simply because it is convenient if a correct icon already exists.

---

# 1.6 Layout Engineering Rules

Prefer responsive and structurally correct Flutter layouts.

Use appropriate combinations of:
- `Row`
- `Column`
- `Expanded`
- `Flexible`
- `Spacer`
- `SizedBox`
- `Padding`
- `Align`
- `Center`
- `ConstrainedBox`
- `LayoutBuilder`
- `MediaQuery`
- `Wrap`
- `GridView`
- `ListView`
- `CustomScrollView`
- `Sliver*`
- `Stack` only when visual layering genuinely requires it.

Avoid using a huge `Stack` with manually positioned elements for a normal dashboard/application layout.

Use constraints and flex ratios to reproduce the structure.

---

# 1.7 Desktop, Tablet, and Mobile Responsiveness

The screen may be desktop-first or mobile-first. The reference determines the primary target.

Do not assume one static layout works on all devices.

When relevant, define responsive behavior such as:

- Desktop:
  - persistent navigation/sidebar,
  - multi-column content,
  - fixed/limited main content widths,
  - secondary right panels,
  - larger gutters.

- Tablet:
  - reduced sidebar or navigation rail,
  - reduced gutters,
  - possible right-panel stacking.

- Mobile:
  - drawer/bottom navigation/compact navigation,
  - single-column layout,
  - stacked cards,
  - full-width controls,
  - responsive text and spacing,
  - appropriate scrolling.

Use the project's existing breakpoint system if one exists.

If none exists, create centralized breakpoints rather than scattering width checks throughout the code.

Example conceptual breakpoints:
- compact/mobile,
- medium/tablet,
- expanded/desktop.

Do not force the desktop screenshot layout onto a narrow phone viewport.

---

# 1.8 Reference Viewport Reproduction

For visual comparison, the live screenshot must be captured at the same or very similar viewport size as the reference.

Before judging layout differences:
1. determine reference screenshot dimensions,
2. configure the emulator/window/device to a comparable size,
3. account for system chrome/title bars if present,
4. confirm Flutter logical size/device pixel ratio where relevant,
5. compare the same application state.

A comparison at a different aspect ratio is not a valid pixel-level comparison.

---

# 1.9 Design Tokens

If repeated values are discovered during matching, consolidate them.

Examples:
- sidebar width,
- page horizontal padding,
- card radius,
- card border color,
- dashboard gap,
- section heading style,
- muted text color,
- icon tile size.

Place tokens in the existing theme/constants system.

Do not introduce a new design-token framework if the repository already has one.

---

# 1.10 Component Reuse

If multiple visually identical components appear in the reference, implement one reusable widget.

Examples:
- metric/stat cards,
- automation cards,
- navigation items,
- status badges,
- activity rows,
- template rows,
- section headers,
- icon tiles.

Expose configuration through constructor parameters instead of duplicating code.

---

# 1.11 UI State Accuracy

Match not only the screen structure, but the exact state visible in the reference.

Examples:
- active sidebar item,
- selected filter tab,
- search field placeholder,
- toggle on/off states,
- status badges,
- list item content,
- success/error icons,
- timestamps,
- right-panel contents.

Mock data should reproduce the reference content closely enough to validate layout.

---

# 2. API Backend Implementation

When tasked with implementing or connecting to an API backend, the agent must follow this strict 9-step sequence to maintain architectural boundaries:

1. **Network DTO:** Create `lib/data/network/model/<feature>/network_<feature>_model.dart`

2. **Retrofit Service:** Create `lib/data/network/service/<feature>/<feature>_service.dart`

3. **Data Source:** Create `lib/data/network/data_source/<feature>_network_data_source.dart` (Must catch exceptions and return `Result<T>`)

4. **Domain Resource:** Create `lib/models/<feature>/<feature>_resource.dart`

5. **Extension Mapper:** Create `lib/models/<feature>/<feature>_ext.dart` (to map DTOs to Domain resources)

6. **Repository:** Create `lib/repository/<feature>_repository.dart` (Returns `Result<T>`)

7. **Network DI:** Register the service and data source in `lib/di/di_network_module.dart`

8. **Repository DI:** Register the repository in `lib/di/di_repository_module.dart`

9. **App Providers:** Expose the repository in `lib/di/app_repository_providers.dart` if needed globally.

## Critical Rules for APIs

- Never call Dio or Retrofit directly from the UI or Blocs.

- Never put `try/catch` blocks inside Blocs; the Repository/DataSource layer handles exceptions and returns a `dartz` `Either<Failure, T>` (aliased as `Result<T>`).

- Run `dart run build_runner build --delete-conflicting-outputs` after adding any models, DI, or services.

---

# 2.1 Keep UI and API Work Independent When Necessary

If the API is not ready:
- finish the screen using mock Bloc state,
- make the mock state structurally similar to the future domain model,
- avoid embedding mock logic inside presentation widgets.

When the API is added later:
- replace mock state generation with repository-backed Bloc events,
- do not redesign the UI unless API constraints require it.

---

# 3. Iterative UI Perfection via Screenshot & Flutter MCP Toolkit

When the user provides a reference image (screenshot or mockup) and asks the agent to implement the UI perfectly, the agent must employ the following autonomous workflow using the **Flutter MCP Toolkit**.

## Step 1: Initial Code Drafting & Testing

1. Analyze the reference screenshot and map it to Material 3 components and the project's atomic design system.

2. Write the initial UI code following the "UI Implementation First" guidelines above.

3. Run `flutter analyze` and `flutter test` to ensure there are no syntax or compilation errors.

---

## Step 2: Running on Device & Connecting MCP Toolkit

1. Run the app on an available device or emulator using the appropriate command (e.g., `flutter run -d <deviceId>`).

2. The agent uses the **Flutter MCP Toolkit** (`mcp_toolkit` / `flutter-mcp-toolkit`) to connect to the running VM.

   - *Note: The toolkit acts as an AI-to-Flutter runtime bridge, exposing tools like `fmt_get_screenshots`, `fmt_semantic_snapshot`, and `fmt_hot_reload_flutter`.*

---

## Step 3: The Iterative Perfection Loop

This is a continuous loop where the agent compares the live app output to the reference image and adjusts the code.

1. **Capture Live State:**

   - Call `fmt_get_screenshots` or `fmt_capture_ui_snapshot` to get an image of the current live UI.

   - Call `fmt_semantic_snapshot` or `fmt_get_view_details` if structural or accessibility tree inspection is needed to understand widget bounds and nesting.

2. **Visual & Semantic Comparison:**

   - Compare the live screenshot against the provided reference image.

   - Look for mismatches in padding, margins, colors, typography, alignment, overflow, and component sizing.

3. **Check for Errors:**

   - Call `fmt_get_app_errors` to ensure no rendering exceptions (like "RenderFlex overflowed") or state errors are occurring on the screen.

4. **Apply Fixes:**

   - Modify the underlying Dart files (e.g., tweaking `Padding`, `SizedBox`, `Theme.of(context).colorScheme` values, or correcting widget structures).

5. **Hot Reload:**

   - Call `fmt_hot_reload_flutter` via the MCP Toolkit to instantly apply the changes without restarting the app.

6. **Repeat:**

   - Go back to **Capture Live State** and repeat the process.

   - The agent will continuously loop (Code Change -> Hot Reload -> Capture -> Compare) until the live screenshot is practically indistinguishable from the reference image.

---

## Flutter MCP Toolkit Tools Reference for UI Tasks

- `fmt_hot_reload_flutter` / `fmt_hot_restart_flutter`: To quickly apply UI code changes.

- `fmt_get_screenshots`: Retrieves the visual state of the application.

- `fmt_semantic_snapshot`: Retrieves the accessibility/render tree to understand layout hierarchies without guessing.

- `fmt_get_app_errors`: Retrieves the latest Flutter framework errors (crucial for catching layout overflows).

- `fmt_tap_widget` / `fmt_enter_text`: Useful if the target UI state requires opening a dialog, focusing an input, or navigating to a specific tab before taking the screenshot.

---

# 3.1 MCP Tool Name Compatibility

Different versions of Flutter MCP Toolkit may expose slightly different tool names.

The agent must:
1. inspect the available MCP tools,
2. identify equivalent screenshot/semantics/error/hot-reload/navigation tools,
3. use the available equivalent instead of failing solely because a documented alias is missing.

Never claim MCP cannot perform the task before checking the tools actually exposed by the connected MCP server.

---

# 3.2 Required Autonomous Visual QA Loop

The following loop is mandatory for reference-image tasks:

REFERENCE
  -> inspect screenshot
  -> inspect code
  -> run app
  -> navigate to target screen/state
  -> capture screenshot
  -> compare
  -> create mismatch list
  -> edit code
  -> analyze errors
  -> hot reload/restart
  -> capture again
  -> compare again
  -> repeat until accepted

The agent must not ask the user to manually compare screenshots if the environment can capture them programmatically.

---

# 3.3 Comparison Order: Fix the Biggest Errors First

Always fix mismatch categories in this order:

1. Overall viewport/layout structure
2. Sidebar/header/main/right-panel dimensions
3. Major component widths/heights
4. Spacing/padding/gaps
5. Typography/family/weight/size/line height
6. Colors/backgrounds/borders
7. Icons/logos
8. Border radii
9. Shadows
10. Small alignment/optical corrections

Do not waste iterations tuning a 1px icon gap while the main column width is still wrong.

---

# 3.4 Build a Visual Mismatch Checklist Every Iteration

After each screenshot comparison, maintain a concise mismatch list.

Example:

- Sidebar 18 px too wide.
- Header content starts 24 px too far right.
- Main title font weight should be 700, currently 600.
- Stat cards are 12 px too tall.
- Search input border is too dark.
- Right panel begins 10 px too low.
- Automation cards need 2 px larger radius.
- Active navigation background should be more saturated.
- Secondary text is too dark.
- Row divider positions do not match.

Then change only the relevant files/tokens for those mismatches.

After hot reload, capture again and rebuild the list.

---

# 3.5 Screenshot Comparison Method

When the environment supports image processing, perform both visual inspection and image-diff analysis.

Recommended process:
1. Resize/crop only to align equivalent app content regions when necessary.
2. Never distort the reference.
3. Compare same-size screenshots.
4. Use overlay or difference images when possible.
5. Inspect large-error regions first.
6. Compute a similarity/difference metric if tooling is available.
7. Treat the metric as supporting evidence, not as the only quality signal.

Important:
- Anti-aliasing, OS font rendering, device pixel ratio, shadows, and image compression can cause tiny pixel differences.
- Do not chase meaningless anti-aliasing noise.
- Focus on visually meaningful geometry, style, and hierarchy differences.

---

# 3.6 Target Quality / Stopping Criteria

The agent may stop the visual iteration loop only when all of the following are true:

- No `flutter analyze` errors caused by the implementation.
- Relevant tests pass, or failures unrelated to the task are clearly documented.
- No runtime Flutter exceptions.
- No RenderFlex overflow.
- No clipped required content.
- Target UI state matches the reference.
- Major component geometry is aligned.
- Typography is visually close.
- Colors are visually close.
- Icons/logos are correct or the closest project-approved equivalent.
- Responsive behavior is not broken.
- Final screenshot has been captured after the last code change.
- Final screenshot has been compared against the reference.
- No obvious mismatch remains that can reasonably be fixed from the available information.

"Looks good" is not a valid stopping criterion by itself.

---

# 3.7 If the UI Is Already Close

Do not perform an unnecessary rewrite.

Prefer focused refinements:
- token adjustments,
- typography updates,
- precise padding/gaps,
- card dimensions,
- panel widths,
- icon sizing,
- border/shadow tuning.

Preserve existing business logic and working state management.

---

# 3.8 If the UI Is Far From the Reference

If the existing widget hierarchy fundamentally prevents a correct layout:
1. identify the structural cause,
2. refactor the smallest necessary section,
3. preserve feature behavior,
4. rebuild the visual structure correctly,
5. resume screenshot iteration.

Do not keep stacking hacks on top of an incorrect hierarchy.

---

# 3.9 Hot Reload vs Hot Restart

Use hot reload for:
- spacing,
- colors,
- typography,
- widget structure changes that support reload.

Use hot restart when:
- theme initialization changes,
- dependency injection changes,
- localization generation changes,
- route/bootstrap changes,
- static/global state prevents refresh,
- hot reload does not correctly apply the modification.

If needed, fully stop and rerun the app.

---

# 3.10 Navigation to the Exact Reference State

Before capturing:
- open the correct route,
- select the correct sidebar/tab,
- scroll to the correct position,
- open required dialogs/menus,
- populate fields,
- use mock data/state corresponding to the reference.

Use MCP interaction tools such as:
- `fmt_tap_widget`,
- `fmt_enter_text`,
- equivalent navigation/input tools.

A screenshot of the wrong state cannot be used to judge implementation accuracy.

---

# 4. Desktop Application Matching Rules

For desktop-first Flutter applications, pay special attention to:

- exact window/viewport dimensions,
- persistent navigation/sidebar width,
- titlebar/window chrome assumptions,
- mouse hover states,
- larger whitespace ratios,
- content max width,
- horizontal card layouts,
- right-side information rails,
- fixed versus scrollable panel behavior,
- scrollbar behavior,
- desktop text density,
- keyboard focus styles,
- pointer/hover cursors where applicable.

Use `LayoutBuilder` and window constraints instead of assuming a fixed 1920px desktop.

The reference screenshot should be reproduced at its actual or closest possible content size.

---

# 4.1 Example Dashboard Matching Strategy

For a dashboard similar to the reference:

1. Match sidebar width and background.
2. Match top app bar height.
3. Match page left/right padding.
4. Match page heading position.
5. Match button positions and sizes.
6. Match summary/stat card grid.
7. Match tabs and search/sort row.
8. Match primary list/card widths.
9. Match secondary/right sidebar width.
10. Match each list card's internal layout.
11. Match badge/toggle/button alignment.
12. Match activity/template panel spacing.
13. Match logo and navigation icon sizing.
14. Match all typography.
15. Tune borders/shadows/radii.
16. Capture final screenshot and compare.

---

# 5. Mobile Application Matching Rules

For mobile reference screenshots:

- honor safe areas,
- account for status/navigation bars,
- match app bar height,
- match bottom navigation/drawer/tab behavior,
- avoid desktop-only fixed widths,
- use scroll views correctly,
- match phone viewport size,
- verify keyboard behavior for text fields,
- preserve touch target usability,
- ensure cards/list rows adapt without overflow.

If the reference includes a particular phone aspect ratio, use a matching emulator profile whenever possible.

---

# 6. Testing and Static Analysis

After significant code changes:

Run:
- `dart format .`
- `flutter analyze`
- relevant `flutter test` commands

If generated code changed:
- `dart run build_runner build --delete-conflicting-outputs`

If localization generation is required by the project:
- run the project-appropriate localization generation command.

Do not leave the repository in an unformatted state.

---

# 6.1 Runtime Error Checks

During every important visual iteration, inspect runtime errors.

Look for:
- RenderFlex overflow,
- unbounded constraints,
- missing assets,
- image decode failures,
- localization lookup failures,
- provider/Bloc scope failures,
- route errors,
- setState-after-dispose,
- null-state exceptions,
- failed assertions.

Fix runtime errors before continuing visual polishing.

---

# 7. Code Quality Rules

- Prefer `const` widgets where appropriate.
- Keep widget build methods understandable.
- Extract repeated or complex UI into widgets.
- Avoid deeply nested anonymous widgets when a named widget improves clarity.
- Preserve semantic labels/accessibility where practical.
- Use keys where needed for stable list behavior/testing.
- Keep business logic out of widgets.
- Keep API logic out of Blocs and UI.
- Avoid duplicating theme values.
- Use existing utilities/helpers before creating new ones.
- Do not introduce a package merely for a minor styling task unless justified.

---

# 8. Do Not Overfit One Screenshot

The reference screenshot is the visual truth for the target state, but the implementation must still behave as a real app.

Do not:
- create the entire screen as one image,
- use absolute pixel positioning for every element,
- disable scrolling just because content fits one screenshot,
- make text non-responsive,
- break accessibility,
- break other routes/screen sizes.

The correct goal is:
"real Flutter layout that renders like the reference,"
not:
"a screenshot pasted into Flutter."

---

# 9. Preserve Existing Functionality

When improving an existing screen:
- keep current event handlers,
- keep Bloc wiring,
- keep navigation behavior,
- keep data models,
- keep API calls,
- keep analytics hooks,
- keep accessibility hooks,
- keep tests when still valid.

Only change behavior if the reference or user request requires it.

Visual refactoring must not silently break application logic.

---

# 10. Repository Inspection Checklist Before Editing

Before implementation, inspect relevant files:

- `pubspec.yaml`
- `.github/copilot-instructions.md`
- this skill file
- `lib/main.dart`
- app/router files
- theme files
- localization ARB files
- relevant feature directory
- shared widgets
- assets/fonts configuration
- dependency injection setup
- existing tests for the feature

Do not assume paths that differ from the actual repository.

If the repository architecture differs slightly from the documented example paths, follow the repository's established convention while preserving the architectural intent of this skill.

---

# 11. Reference Screenshot Analysis Checklist

For every new reference screenshot, inspect:

- screenshot dimensions,
- viewport aspect ratio,
- device type,
- background,
- main layout regions,
- navigation,
- header,
- text hierarchy,
- content hierarchy,
- repeated components,
- controls,
- icons,
- logos,
- state,
- spacing rhythm,
- colors,
- borders,
- shadows,
- radii,
- scroll position,
- responsive clues.

Convert this into an implementation plan before editing.

---

# 12. Recommended Execution Workflow

When the user sends a reference image and says "make my Flutter UI match this," execute the following without waiting for repeated reminders:

### Phase A — Understand
1. Inspect reference image.
2. Inspect current screenshot if supplied.
3. Identify viewport/device target.
4. Identify target route/state.

### Phase B — Inspect Repository
5. Find existing screen.
6. Find theme/tokens.
7. Find assets/fonts/icons.
8. Find similar reusable widgets.
9. Determine whether implementation exists or must be created.

### Phase C — Implement
10. Build/refactor layout.
11. Add localization.
12. Add/reuse components.
13. Add mock Bloc data if API is unavailable.
14. Preserve architecture.

### Phase D — Validate Code
15. Format.
16. Analyze.
17. Test.
18. Generate code if necessary.

### Phase E — Run
19. Discover Flutter devices.
20. Run on the correct target.
21. Connect Flutter MCP Toolkit.
22. Navigate to the correct state.

### Phase F — Compare
23. Capture screenshot.
24. Capture semantic snapshot when needed.
25. Check runtime errors.
26. Compare against reference.
27. Build mismatch list.

### Phase G — Refine
28. Fix largest mismatches.
29. Hot reload/restart.
30. Capture again.
31. Recompare.
32. Repeat.

### Phase H — Final Verification
33. Run final analyze/test checks.
34. Confirm no runtime errors.
35. Capture final screenshot.
36. Compare one last time.
37. Report changed files and any remaining limitations.

---

# 13. When the Reference and Current Screenshot Are Both Provided

Treat:
- reference screenshot = desired target,
- current screenshot = baseline evidence.

Do not infer that the current screenshot accurately represents the current code if it is stale; still run the application whenever possible.

Start by identifying concrete differences between the two images, such as:
- sidebar width,
- horizontal placement,
- page scale,
- font sizes,
- content density,
- card dimensions,
- column ratios,
- right panel size,
- gaps,
- color saturation,
- icon design,
- border radius,
- search/input styling,
- button dimensions.

Use those differences as the first-pass correction plan.

---

# 14. Visual Accuracy Heuristics

Pay attention to optical details that commonly make an implementation feel "off":

- Font weight often matters more than a 1px font-size difference.
- Line height can make cards appear too tall or too short.
- Sidebar width strongly affects the whole desktop composition.
- A slightly wrong page background can make every card look wrong.
- Muted text colors affect perceived hierarchy.
- Border opacity often matters more than shadow strength.
- Icon tile/background dimensions affect alignment.
- Different icons can make an otherwise-correct row feel inaccurate.
- Button padding changes both visual size and text centering.
- Toggle dimensions differ between design systems; do not accept Material defaults automatically.
- Search fields and pills frequencies require custom heights/radii.
- Repeated 4/8/12/16/24/32 spacing patterns should be identified rather than guessed independently.

---

# 15. Precision Without Fragility

It is acceptable to use exact values measured from the reference for:
- navigation widths,
- card heights,
- gaps,
- radii,
- icon sizes,
- typography.

However:
- centralize repeated values,
- combine exact design tokens with responsive constraints,
- do not create brittle absolute positioning,
- ensure reasonable behavior around the target size.

---

# 16. If Flutter MCP Toolkit Is Unavailable or Fails

Do not abandon the visual QA process immediately.

Fallback sequence:
1. verify MCP server configuration,
2. inspect available MCP tools,
3. reconnect/restart the running Flutter app,
4. retry toolkit connection,
5. use equivalent screenshot tooling available in the environment,
6. use Flutter integration/golden screenshot tooling if already configured,
7. use platform/emulator screenshot capture as a fallback.

Clearly state the limitation only if no runtime screenshot mechanism is available after reasonable attempts.

Do not falsely claim a visual match without a final captured screenshot.

---

# 17. Golden Tests

If the repository already uses golden tests:
- update/add the relevant golden test when appropriate,
- use a deterministic device size,
- use deterministic fonts/assets,
- keep golden baselines aligned with approved reference behavior.

Do not introduce a large new golden-testing framework solely for a one-off task unless the user requests it.

---

# 18. Final Agent Report

At the end of a completed task, report concisely:

- target screen/route,
- whether it was created or modified,
- important files changed,
- major visual changes made,
- device/viewport used,
- analyze/test status,
- runtime error status,
- screenshot comparison status,
- any remaining mismatch or environmental limitation.

Do not say "pixel-perfect" unless the result was actually compared at a matching viewport and the remaining differences are negligible.

---

# 19. Example Final Completion Standard

A good completion statement is:

"Implemented and refined the Automations desktop screen against the supplied reference. I matched the sidebar proportions, header, stats cards, filters, automation rows, right activity/templates rail, typography hierarchy, colors, borders, and spacing. The app was run at the reference-sized desktop viewport, checked with Flutter MCP for runtime errors, captured after the final hot reload, and visually compared to the reference. `flutter analyze` passes for the changed code and no RenderFlex overflows remain."

Do not use this wording unless those steps were actually completed.

---

# 20. Instruction the Agent Must Internally Follow Every Time a Reference Image Is Given

Whenever the user provides a reference screenshot, automatically interpret the request as:

"Use this image as the visual source of truth. Inspect the Flutter repository and determine whether the target screen already exists. If it does not exist, implement it properly using the project architecture. If it exists, modify the existing implementation rather than duplicating it. Reuse the project's theme, fonts, assets, icons, localization, shared widgets, Bloc patterns, and routing. Run the app at a viewport matching the reference, use Flutter MCP Toolkit to inspect the live UI and errors, capture screenshots, compare them against the reference, fix the code, hot reload/restart, and repeat until no meaningful visual mismatch remains. Preserve application behavior and responsive quality. Do not stop after the first pass."

---

# 21. Short Command Trigger

If the user says any equivalent of:

- "match this screenshot"
- "make this UI same"
- "implement this design"
- "fix current UI according to reference"
- "copy this layout"
- "make it pixel perfect"
- "compare and update Flutter UI"
- "use Flutter MCP to match this"

then this entire skill applies automatically.

---

# 22. Mandatory Per-Task Checklist

Before finishing any reference-driven UI task, verify:

[ ] Reference image analyzed
[ ] Target viewport identified
[ ] Existing screen searched
[ ] Theme/assets/fonts/icons inspected
[ ] Correct screen implemented/modified
[ ] User-facing strings localized
[ ] Reusable components extracted where appropriate
[ ] Responsive behavior considered
[ ] Dart formatted
[ ] Flutter analyze run
[ ] Relevant tests run
[ ] App launched
[ ] Correct screen/state opened
[ ] Flutter MCP connected or fallback documented
[ ] Runtime errors checked
[ ] Screenshot captured
[ ] Screenshot compared to reference
[ ] Mismatch list created
[ ] At least one refinement pass performed when mismatches existed
[ ] Final screenshot captured after final code change
[ ] Final comparison performed
[ ] No obvious remaining UI mismatch
[ ] No overflow/runtime errors
[ ] Final summary provided

If any required checkbox is false, the task is not yet complete unless an external limitation prevents it. In that case, clearly report the limitation.

---

# 23. Final Principle

The agent is responsible for both implementation and visual verification.

Do not place the burden on the user to repeatedly say:
"font is wrong,"
"sidebar is too wide,"
"card is too tall,"
"position is off,"
or
"compare the screenshot again."

The agent must proactively detect and correct those differences through the screenshot/MCP iteration loop.

Build the real Flutter UI.
Run it.
Inspect it.
Capture it.
Compare it.
Fix it.
Repeat until it matches.
