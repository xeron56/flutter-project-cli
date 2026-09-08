import 'package:flutter_bloc_app_template/src/project_readme_template.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('generateProjectReadme', () {
    const projectName = 'fitness_tracker';
    const packageName = 'com.example.fitness_tracker';
    const appTitle = 'Fitness Tracker';

    late String readme;

    setUp(() {
      readme = generateProjectReadme(
        projectName: projectName,
        packageName: packageName,
        appTitle: appTitle,
      );
    });

    test('includes project title, package name, and application metadata', () {
      expect(readme, contains('# Fitness Tracker (`fitness_tracker`)'));
      expect(readme, contains('- **Package / Application ID**: `com.example.fitness_tracker`'));
      expect(readme, contains('- **Dart Package**: `fitness_tracker`'));
    });

    test('includes quickstart and all environment flavors', () {
      expect(readme, contains('flutter run -t lib/main_dev.dart --flavor dev'));
      expect(readme, contains('flutter run -t lib/main_qa.dart --flavor qa'));
      expect(readme, contains('flutter run -t lib/main_prod.dart --flavor prod'));
    });

    test('includes screenshot-driven UI first workflow instructions', () {
      expect(
        readme,
        contains('Phase 1: UI Implementation from Screenshots / Mockups'),
      );
      expect(readme, contains('lib/features/<name>/view/<name>_screen.dart'));
      expect(readme, contains('lib/features/<name>/widget/'));
      expect(readme, contains('<name>_bloc.dart'));
      expect(readme, contains('lib/l10n/intl_en.arb'));
      expect(readme, contains('lib/theme/'));
      expect(readme, contains('mock or dummy data'));
    });

    test('includes 9-step API backend integration sequence', () {
      expect(
        readme,
        contains('Phase 2: API Backend Integration (9-Step Sequence)'),
      );
      expect(readme, contains('**Network DTO**'));
      expect(readme, contains('**Retrofit Service**'));
      expect(readme, contains('**Network Data Source**'));
      expect(readme, contains('**Domain Resource**'));
      expect(readme, contains('**Extension Mapper**'));
      expect(readme, contains('**Repository**'));
      expect(readme, contains('**Network DI**'));
      expect(readme, contains('**Repository DI**'));
      expect(readme, contains('**App Providers**'));
      expect(readme, contains('Result<T>'));
      expect(
        readme,
        contains(
          'Never call Dio, Retrofit, or HTTP directly from UI widgets or Blocs',
        ),
      );
    });

    test('includes AI agent guidelines and MCP toolkit workflow', () {
      expect(readme, contains('AI Agent Integration'));
      expect(readme, contains('Antigravity'));
      expect(readme, contains('Codex'));
      expect(readme, contains('Claude'));
      expect(readme, contains('Cursor'));
      expect(readme, contains('Gemini'));
      expect(readme, contains('Flutter MCP Toolkit Workflow'));
      expect(readme, contains('fmt_get_screenshots'));
      expect(readme, contains('fmt_hot_reload_flutter'));
      expect(readme, contains('fmt_get_app_errors'));
    });

    test('does NOT contain CLI installer or generator self-instructions', () {
      expect(readme, isNot(contains('flutter pub global activate')));
      expect(
        readme,
        isNot(contains('Create a New Project From This Template')),
      );
      expect(readme, isNot(contains('flutter_project_cli --project-name')));
    });
  });
}
