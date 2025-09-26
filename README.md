# flutter-bloc-app-template 🤖
This is a basic Flutter project template that uses the BLoC pattern architecture for state management. 
It is a good starting point for creating a new Flutter app that uses BLoC for state management.

This template is focused on delivering a project with **static analysis** and **continuous integration** already in place.


## Features 🦄
- Theme support
- BLoC pattern [**bloc**](https://pub.dev/packages/bloc)
- Service Locator using [**get_it**](https://pub.dev/packages/get_it)
- Localization using [**intl**](https://pub.dev/packages/intl)
- CI Setup with GitHub Actions
- Codecov Setup with GitHub Actions
- Unit test coverage
- Integration tests

## Configuration
The template has 3 flavors:
- dev
- prod
- qa

The template has 3 build variants:
- debug
- profile
- release

For example dev configuration for Android Studio looks like:

<p align="left">
<img src="/preview/config/dev.png" width="32%"/>
</p>

- dev: --flavor dev -t lib/main_dev.dart

## Android Screenshots
<p align="left">
<img src="/preview/android/launches_android_dark_theme.png" width="32%"/>
<img src="/preview/android/launches_android_light_theme.png" width="32%"/>
</p>

<p align="left">
<img src="/preview/android/messages_android_dark_theme.png" width="32%"/>
<img src="/preview/android/messages_android_ligth_theme.png" width="32%"/>
</p>

## iOS Screenshots
<p align="left">
<img src="/preview/ios/launches_ios_dark_theme.png" width="32%"/>
<img src="/preview/ios/launches_ios_light_theme.png" width="32%"/>
</p>

<p align="left">
<img src="/preview/ios/messages_ios_dark_theme.png" width="32%"/>
<img src="/preview/ios/messages_ios_ligth_theme.png" width="32%"/>
</p>


## Static Analysis 🔍

This template is using [**analyzer**](https://pub.dev/packages/analyzer)

Supported Lint [**Rules**](https://dart-lang.github.io/linter/lints/)

Supported Dart Code [**Metrics**](https://dartcodemetrics.dev/docs/getting-started/introduction)

Dart [**Lint**](https://github.com/passsy/dart-lint)

## CI ⚙️
This template is using [**GitHub Actions**](https://github.com/ashtanko/flutter_app_skeleton/actions) as CI. You don't need to setup any external service and you should have a running CI once you start using this template.

## How to build 🛠️

The Project uses [**FlutterGen**](https://github.com/FlutterGen/flutter_gen) to generate localizations, dependencies and mocks

Activate flutter_gen using dart pub global activate flutter_gen command if you haven't done that before.

after add export PATH="$PATH":"$HOME/.pub-cache/bin" to bash_profile

``` bash
# clean project, install dependencies & generate sources
make

# generate localizations, dependencies, image assets, colors, fonts
make gen

# generate localizations
make localize

# analyze the project
check
```

## Reminders 🧠
Change name in pubspec.yaml file

Remove anything you don't need

Configure analysis_options.yaml for your needs

## Contributing 🤝

Feel free to open a issue or submit a pull request for any bugs/improvements.

