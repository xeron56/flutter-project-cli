// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter BLoC Template';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get dynamicColorSettingsItemTitle => 'Use dynamic colors';

  @override
  String get dynamicColorSettingsItemDescription =>
      'Adapt app colors to your wallpaper';

  @override
  String get darkThemeTitle => 'Dark Theme';

  @override
  String get darkThemeOnSettingsItemTitle => 'Dark';

  @override
  String get darkThemeOffSettingsItemTitle => 'Light';

  @override
  String get darkThemeFollowSystemSettingsItemTitle => 'System default';

  @override
  String get tryAgainButton => 'Try Again';

  @override
  String get emptyList => 'Empty list';
}
