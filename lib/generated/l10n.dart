// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Flutter BLoC Template`
  String get appTitle {
    return Intl.message(
      'Flutter BLoC Template',
      name: 'appTitle',
      desc: 'The title of the application',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message(
      'Settings',
      name: 'settingsTitle',
      desc: 'The title of the settings screen',
      args: [],
    );
  }

  /// `Appearance`
  String get appearanceTitle {
    return Intl.message(
      'Appearance',
      name: 'appearanceTitle',
      desc: 'Title for appearance settings',
      args: [],
    );
  }

  /// `Use dynamic colors`
  String get dynamicColorSettingsItemTitle {
    return Intl.message(
      'Use dynamic colors',
      name: 'dynamicColorSettingsItemTitle',
      desc: 'Title for enabling dynamic colors from wallpaper',
      args: [],
    );
  }

  /// `Adapt app colors to your wallpaper`
  String get dynamicColorSettingsItemDescription {
    return Intl.message(
      'Adapt app colors to your wallpaper',
      name: 'dynamicColorSettingsItemDescription',
      desc: 'Description for dynamic color setting',
      args: [],
    );
  }

  /// `Dark Theme`
  String get darkThemeTitle {
    return Intl.message(
      'Dark Theme',
      name: 'darkThemeTitle',
      desc: 'Title for dark theme settings',
      args: [],
    );
  }

  /// `Dark`
  String get darkThemeOnSettingsItemTitle {
    return Intl.message(
      'Dark',
      name: 'darkThemeOnSettingsItemTitle',
      desc: 'Dark theme option',
      args: [],
    );
  }

  /// `Light`
  String get darkThemeOffSettingsItemTitle {
    return Intl.message(
      'Light',
      name: 'darkThemeOffSettingsItemTitle',
      desc: 'Light theme option',
      args: [],
    );
  }

  /// `System default`
  String get darkThemeFollowSystemSettingsItemTitle {
    return Intl.message(
      'System default',
      name: 'darkThemeFollowSystemSettingsItemTitle',
      desc: 'Option to follow system theme',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgainButton {
    return Intl.message(
      'Try Again',
      name: 'tryAgainButton',
      desc: 'Label for retry buttons',
      args: [],
    );
  }

  /// `Empty list`
  String get emptyList {
    return Intl.message(
      'Empty list',
      name: 'emptyList',
      desc: 'Displayed when a list has no items',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
