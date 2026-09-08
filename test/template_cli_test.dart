import 'dart:io';

import 'package:flutter_bloc_app_template/template_cli.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Template CLI Project Generation', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('cli_gen_test_');
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('generates project with human & AI agent friendly README', () async {
      final targetPath = '${tempDir.path}${Platform.pathSeparator}recipe_app';

      await runTemplateCli([
        '--project-name',
        'recipe_app',
        '--package-name',
        'com.company.recipe_app',
        '--output',
        targetPath,
        '--skip-setup',
        '--no-git',
      ]);

      final targetDir = Directory(targetPath);
      expect(targetDir.existsSync(), isTrue);

      // Verify README.md
      final readmeFile = File('$targetPath${Platform.pathSeparator}README.md');
      expect(readmeFile.existsSync(), isTrue);

      final readmeContent = readmeFile.readAsStringSync();

      // Check title and metadata
      expect(readmeContent, contains('# Recipe App (`recipe_app`)'));
      expect(
        readmeContent,
        contains('- **Package / Application ID**: `com.company.recipe_app`'),
      );

      // Check screenshot-to-code and 9-step API workflow sections
      expect(
        readmeContent,
        contains('Phase 1: UI Implementation from Screenshots / Mockups'),
      );
      expect(
        readmeContent,
        contains('Phase 2: API Backend Integration (9-Step Sequence)'),
      );

      // Verify it does NOT have the old CLI install instructions
      expect(
        readmeContent,
        isNot(contains('flutter pub global activate')),
      );
      expect(
        readmeContent,
        isNot(contains('flutter_project_cli --project-name')),
      );

      // Verify CLI-specific files are not copied to the generated app
      final cliFile = File(
        '${targetDir.path}${Platform.pathSeparator}lib'
        '${Platform.pathSeparator}template_cli.dart',
      );
      expect(cliFile.existsSync(), isFalse);

      final cliSrcDir = Directory(
        '${targetDir.path}${Platform.pathSeparator}lib'
        '${Platform.pathSeparator}src',
      );
      expect(cliSrcDir.existsSync(), isFalse);

      // Verify CLI-specific tests are not copied to the generated app
      final cliTestFile = File(
        '${targetDir.path}${Platform.pathSeparator}test'
        '${Platform.pathSeparator}template_cli_test.dart',
      );
      expect(cliTestFile.existsSync(), isFalse);

      final readmeTestFile = File(
        '${targetDir.path}${Platform.pathSeparator}test'
        '${Platform.pathSeparator}project_readme_template_test.dart',
      );
      expect(readmeTestFile.existsSync(), isFalse);

      // Verify app tests are preserved in the generated app
      final widgetTestFile = File(
        '${targetDir.path}${Platform.pathSeparator}test'
        '${Platform.pathSeparator}widget_test.dart',
      );
      expect(widgetTestFile.existsSync(), isTrue);

      final connectivityTestFile = File(
        '${targetDir.path}${Platform.pathSeparator}test'
        '${Platform.pathSeparator}widgets'
        '${Platform.pathSeparator}connectivity_banner_test.dart',
      );
      expect(connectivityTestFile.existsSync(), isTrue);

      // Verify no remaining tests import missing CLI files
      final generatedTestFiles = Directory(
        '${targetDir.path}${Platform.pathSeparator}test',
      )
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'));
      for (final testFile in generatedTestFiles) {
        final content = testFile.readAsStringSync();
        expect(content, isNot(contains('template_cli.dart')));
        expect(content, isNot(contains('project_readme_template.dart')));
      }

      // Verify pubspec.yaml executables entry was stripped
      final pubspecFile = File(
        '${targetDir.path}${Platform.pathSeparator}pubspec.yaml',
      );
      expect(pubspecFile.existsSync(), isTrue);
      final pubspecContent = pubspecFile.readAsStringSync();
      expect(
        pubspecContent,
        isNot(contains('flutter_project_cli: flutter_project_cli')),
      );
      expect(pubspecContent, contains('name: recipe_app'));
    });
  });
}
