
# Moontime

This is an open source Flutter project for listing tv series from the tvmaze.com/api.

## Installation

- Must have Flutter SDK installed on machine
- Download or Pull or Fetch from https://github.com/Dannellkobby/moontime.
- Open in Android studio or VSCode as Flutter project
- To use your own Firebase project
  - Replace /android/app/google-services.json with yours
  - Replace /ios/Runner/GoogleService-Info.plist with yours
  - Run <flutterfire configure>
- Open terminal in project root directory and run <flutter pub get>
- Update values in the local.properties file found here moontime/android/local.properties with the values below
```bash
sdk.dir=<path to your android sdk>
flutter.sdk=<path to your flutter sdk>
flutter.buildMode=debug
flutter.versionName=1.0.0
flutter.versionCode=1
flutter.minSdkVersion=21
flutter.compileSdkVersion=33
```
- Run <flutter pub get>
```bash
flutter pub get
```
- Run <flutter build>
```bash
flutter build
```

### App features
- List all series in the tvMaze Api
- List all episodes airing today
- Search for series by name
- Search for people by name
- Click series to see casts, and episodes
- Click episode to see details and guest casts
- Click cast to see see details and and series featured in
- Save show, episode, cast to favourites
- Remove show, episode, cast from favourites
- Switch theme modes: Light, Dark System
- At the core
  - MVC Architecture design
  - Getx for state management
  - Ios and Android build tested
  - VCS enabled

### TODOs
- Add pin and biometric authentication
- Show Favourite episodes and favourite casts
- Comment code
- Do Unit, Widget and Integration testing
- Do Performance testing
- Create CI/CD pipelines for app signing


## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to test updates as appropriate.

## Current Flutter -doctor output
```bash
flutter doctov -v
[✓] Flutter (Channel stable, 3.3.9, on macOS 13.0.1 22A400 darwin-arm, locale en-GH)
    • Flutter version 3.3.9 on channel stable at /Users/<user>/flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision b8f7f1f986 (3 weeks ago), 2022-11-23 06:43:51 +0900
    • Engine revision 8f2221fbef
    • Dart version 2.18.5
    • DevTools version 2.15.0

[✓] Android toolchain - develop for Android devices (Android SDK version 32.0.0)
    • Android SDK at /Users/<user>/Library/Android/sdk
    • Platform android-33, build-tools 32.0.0
    • Java binary at: /Applications/Android Studio.app/Contents/jre/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 11.0.12+0-b1504.28-7817840)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 14.1)
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Build 14B47b
    • CocoaPods version 1.11.3

[✓] Chrome - develop for the web
    • Chrome at /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

[✓] Android Studio (version 2021.2)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart
    • Java version OpenJDK Runtime Environment (build 11.0.12+0-b1504.28-7817840)

[✓] VS Code (version 1.74.0)
    • VS Code at /Applications/Visual Studio Code.app/Contents
    • Flutter extension can be installed from:
      🔨 https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter

[✓] Connected device (3 available)
    • Android SDK built for arm64 (mobile) • emulator-5554 • android-arm64  • Android 10 (API 29) (emulator)
    • macOS (desktop)                      • macos         • darwin-arm64   • macOS 13.0.1 22A400 darwin-arm
    • Chrome (web)                         • chrome        • web-javascript • Google Chrome 108.0.5359.124

[✓] HTTP Host Availability
    • All required HTTP hosts are available

• No issues found!

```


## License



[MIT](https://choosealicense.com/licenses/mit/)