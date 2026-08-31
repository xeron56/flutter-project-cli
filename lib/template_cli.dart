import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

const _templateProjectName = 'flutter_bloc_app_template';
const _templateAndroidPackage = 'dev.shtanko.flutter_bloc_app_template';
const _templateIosBundleId = 'com.shtanko.template-flutter';
const _templateTitle = 'Flutter BLoC Template';
const _templateKebabName = 'flutter-bloc-app-template';

Future<void> runTemplateCli(List<String> args) async {
  late final _Options options;
  try {
    options = _Options.parse(args);
  } on FormatException catch (error) {
    stderr
      ..writeln(error.message)
      ..writeln('');
    _printUsage();
    exitCode = 64;
    return;
  }

  if (options.help) {
    _printUsage();
    return;
  }

  final error = options.validate();
  if (error != null) {
    stderr
      ..writeln(error)
      ..writeln('');
    _printUsage();
    exitCode = 64;
    return;
  }

  final source = await _templateRoot();
  final output = Directory(options.output!).absolute;
  if (_isInside(output, source)) {
    stderr.writeln('Output must be outside the template directory.');
    exitCode = 73;
    return;
  }

  if (output.existsSync()) {
    if (!options.force) {
      stderr.writeln(
        'Output already exists: ${output.path}\n'
        'Pass --force to replace it.',
      );
      exitCode = 73;
      return;
    }
    output.deleteSync(recursive: true);
  }

  _copyDirectory(source, output);
  _replaceText(output, options);
  _removeTemplateOnlyPubspecEntries(output);
  _sortDartImports(output);
  _moveKotlinPackages(output, options.packageName!);

  stdout
    ..writeln('Created ${options.projectName} at ${output.path}')
    ..writeln('')
    ..writeln('Next commands:')
    ..writeln('  cd ${output.path}')
    ..writeln('  flutter pub get')
    ..writeln('  dart run build_runner build --delete-conflicting-outputs')
    ..writeln('  flutter run -t lib/main_dev.dart --flavor dev')
    ..writeln('')
    ..writeln('AI Agent / Flutter MCP Toolkit Setup (Optional):')
    ..writeln('  1. Install flutter-mcp-toolkit binary (macOS/Linux):')
    ..writeln(
      '     curl -fsSL https://raw.githubusercontent.com/'
      'Arenukvern/mcp_flutter/main/install.sh | bash',
    )
    ..writeln('  2. (mcp_toolkit is already integrated in this template!)')
    ..writeln('  3. AI Agent skills & MCP configuration:')
    ..writeln(
      '     - Antigravity: preconfigured in .agents/skills/ & mcp.json',
    )
    ..writeln('     - Codex: flutter-mcp-toolkit init codex')
    ..writeln('     - Others: flutter-mcp-toolkit init all');
}

Future<Directory> _templateRoot() async {
  final libraryUri = await Isolate.resolvePackageUri(
    Uri.parse('package:flutter_bloc_app_template/template_cli.dart'),
  );
  if (libraryUri == null || !libraryUri.isScheme('file')) {
    return Directory.current.absolute;
  }
  return File.fromUri(libraryUri).parent.parent.absolute;
}

void _printUsage() {
  stdout.writeln('''
Create a new Flutter project from this template.

Install or update from GitHub:
  dart pub global activate --source git \\
    https://github.com/xeron56/flutter-project-cli.git

Usage:
  flutter_project_cli \\
    --project-name my_app \\
    --package-name com.example.my_app \\
    --output my_app

Options:
  --project-name   Dart package name in snake_case.
  --package-name   Native package id, for example com.example.my_app.
  --output         Target directory (for example my_app).
  --force          Delete the output directory first if it exists.
  --help           Print this help.
''');
}

void _copyDirectory(Directory source, Directory target) {
  target.createSync(recursive: true);

  for (final entity in source.listSync(recursive: false, followLinks: false)) {
    final name = _basename(entity.path);
    if (_shouldSkip(name, entity.path)) continue;

    final nextTarget = '${target.path}${Platform.pathSeparator}$name';
    if (entity is Directory) {
      _copyDirectory(entity, Directory(nextTarget));
    } else if (entity is File) {
      File(nextTarget).createSync(recursive: true);
      entity.copySync(nextTarget);
    }
  }
}

bool _shouldSkip(String name, String path) {
  const skippedNames = {
    '.dart_tool',
    '.git',
    '.idea',
    '.packages',
    '.flutter-plugins',
    '.flutter-plugins-dependencies',
    'bin',
    'build',
    'coverage',
    'Pods',
    'Runner.xcworkspace',
    'tool',
  };

  if (skippedNames.contains(name)) return true;
  if (name == 'template_cli.dart' &&
      path.contains('${Platform.pathSeparator}lib${Platform.pathSeparator}')) {
    return true;
  }
  if (name.endsWith('.iml')) return true;
  if (path.contains('${Platform.pathSeparator}.kotlin')) return true;
  return false;
}

bool _isInside(Directory child, Directory parent) {
  final childPath = _normalizedPath(child.path);
  final parentPath = _normalizedPath(parent.path);
  return childPath == parentPath ||
      childPath.startsWith('$parentPath${Platform.pathSeparator}');
}

String _normalizedPath(String path) => Directory(path).absolute.path;

void _replaceText(Directory root, _Options options) {
  final projectName = options.projectName!;
  final packageName = options.packageName!;
  final appTitle = _titleFromProjectName(projectName);
  final kebabName = projectName.replaceAll('_', '-');

  final replacements = <String, String>{
    _templateAndroidPackage: packageName,
    _templateIosBundleId: packageName,
    _templateProjectName: projectName,
    _templateTitle: appTitle,
    _templateKebabName: kebabName,
  };

  for (final file in root.listSync(recursive: true).whereType<File>()) {
    if (!_isLikelyText(file)) continue;

    final original = file.readAsStringSync();
    var updated = original;
    for (final entry in replacements.entries) {
      updated = updated.replaceAll(entry.key, entry.value);
    }

    if (updated != original) {
      file.writeAsStringSync(updated);
    }
  }
}

void _removeTemplateOnlyPubspecEntries(Directory root) {
  final pubspec = File('${root.path}${Platform.pathSeparator}pubspec.yaml');
  if (!pubspec.existsSync()) return;

  final original = pubspec.readAsStringSync();
  final updated = original.replaceFirst(
    RegExp(r'\nexecutables:\n  flutter_project_cli: flutter_project_cli\n'),
    '\n',
  );
  if (updated != original) {
    pubspec.writeAsStringSync(updated);
  }
}

void _sortDartImports(Directory root) {
  for (final file in root.listSync(recursive: true).whereType<File>()) {
    if (!file.path.endsWith('.dart')) continue;
    if (file.path.contains('${Platform.pathSeparator}generated')) continue;

    final source = file.readAsStringSync();
    final importPattern = RegExp(
      r'''import\s+['"][^'"]+['"][^;]*;''',
      multiLine: true,
      dotAll: true,
    );
    final imports = importPattern.allMatches(source).map((match) {
      return match.group(0)!.trimRight();
    }).toList();
    if (imports.length < 2) continue;

    final firstImport = importPattern.firstMatch(source);
    if (firstImport == null) continue;

    final withoutImports = source.replaceAll(importPattern, '').trimLeft();
    final sortedImports = _groupAndSortImports(imports);
    file.writeAsStringSync('$sortedImports\n\n$withoutImports');
  }
}

String _groupAndSortImports(List<String> imports) {
  final groups = <int, List<String>>{};
  for (final import in imports) {
    groups.putIfAbsent(_importGroup(import), () => []).add(import);
  }

  final orderedGroups = groups.keys.toList()..sort();
  final blocks = <String>[];
  for (final key in orderedGroups) {
    final values = groups[key]!
      ..sort((a, b) => _importUri(a).compareTo(_importUri(b)));
    blocks.add(values.join('\n'));
  }
  return blocks.join('\n\n');
}

int _importGroup(String import) {
  final uri = _importUri(import);
  if (uri.startsWith('dart:')) return 0;
  if (uri.startsWith('package:')) return 1;
  return 2;
}

String _importUri(String import) {
  final match = RegExp(r'''['"]([^'"]+)['"]''').firstMatch(import);
  return match?.group(1) ?? import;
}

bool _isLikelyText(File file) {
  final ext = _extension(file.path);
  const binaryExtensions = {
    '.png',
    '.jpg',
    '.jpeg',
    '.gif',
    '.webp',
    '.ttf',
    '.otf',
    '.jar',
    '.a',
    '.so',
    '.dylib',
    '.xcuserstate',
  };
  if (binaryExtensions.contains(ext)) return false;

  try {
    utf8.decode(file.readAsBytesSync());
    return true;
  } on FormatException {
    return false;
  }
}

void _moveKotlinPackages(Directory root, String packageName) {
  final packagePath = packageName.replaceAll('.', Platform.pathSeparator);

  final mainSource = Directory(
    '${root.path}/android/app/src/main/kotlin/'
    '${_templateAndroidPackage.replaceAll('.', Platform.pathSeparator)}',
  );
  final mainTarget = Directory(
    '${root.path}/android/app/src/main/kotlin/$packagePath',
  );
  _moveDirectoryIfExists(mainSource, mainTarget);

  final pluginSource = Directory(
    '${root.path}/android/src/main/kotlin/$_templateAndroidPackage',
  );
  final pluginTarget = Directory(
    '${root.path}/android/src/main/kotlin/$packagePath',
  );
  _moveDirectoryIfExists(pluginSource, pluginTarget);
}

void _moveDirectoryIfExists(Directory source, Directory target) {
  if (!source.existsSync()) return;

  target.createSync(recursive: true);
  for (final entity in source.listSync(recursive: false)) {
    final targetPath =
        '${target.path}${Platform.pathSeparator}'
        '${_basename(entity.path)}';
    if (entity is File) {
      entity.renameSync(targetPath);
    } else if (entity is Directory) {
      _moveDirectoryIfExists(entity, Directory(targetPath));
    }
  }
  source.deleteSync(recursive: true);
  _deleteEmptyParents(source.parent);
}

void _deleteEmptyParents(Directory directory) {
  while (directory.existsSync()) {
    if (directory.listSync().isNotEmpty) return;
    final parent = directory.parent;
    directory.deleteSync();
    directory = parent;
  }
}

String _titleFromProjectName(String projectName) {
  return projectName
      .split('_')
      .where((part) => part.isNotEmpty)
      .map((part) => part[0].toUpperCase() + part.substring(1))
      .join(' ');
}

String _basename(String path) => path.split(Platform.pathSeparator).last;

String _extension(String path) {
  final name = _basename(path);
  final dot = name.lastIndexOf('.');
  if (dot == -1) return '';
  return name.substring(dot).toLowerCase();
}

class _Options {
  const _Options({
    this.projectName,
    this.packageName,
    this.output,
    this.force = false,
    this.help = false,
  });

  final String? projectName;
  final String? packageName;
  final String? output;
  final bool force;
  final bool help;

  static _Options parse(List<String> args) {
    String? projectName;
    String? packageName;
    String? output;
    var force = false;
    var help = false;

    for (var i = 0; i < args.length; i++) {
      final arg = args[i];
      switch (arg) {
        case '--project-name':
          projectName = _readValue(args, ++i, arg);
        case '--package-name':
          packageName = _readValue(args, ++i, arg);
        case '--output':
          output = _readValue(args, ++i, arg);
        case '--force':
          force = true;
        case '--help':
        case '-h':
          help = true;
        default:
          throw FormatException('Unknown argument: $arg');
      }
    }

    return _Options(
      projectName: projectName,
      packageName: packageName,
      output: output,
      force: force,
      help: help,
    );
  }

  static String _readValue(List<String> args, int index, String flag) {
    if (index >= args.length || args[index].startsWith('--')) {
      throw FormatException('Missing value for $flag');
    }
    return args[index];
  }

  String? validate() {
    if (projectName == null || packageName == null || output == null) {
      return 'Missing required arguments.';
    }

    final projectPattern = RegExp(r'^[a-z][a-z0-9_]*$');
    if (!projectPattern.hasMatch(projectName!)) {
      return '--project-name must be snake_case, for example my_app.';
    }

    final packagePattern = RegExp(
      r'^[a-zA-Z][a-zA-Z0-9_]*(\.[a-zA-Z][a-zA-Z0-9_]*)+$',
    );
    if (!packagePattern.hasMatch(packageName!)) {
      return '--package-name must look like com.example.my_app.';
    }

    return null;
  }
}
