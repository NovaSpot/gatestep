# GateStep

A gamified running tracker. Every run is a gate to clear — earn XP, level up,
climb ranks (E → S), allocate stats, and complete quests as you rack up
distance.

## Features

- **Run tracking** — live distance, pace, and elapsed time via GPS (`geolocator`)
- **RPG progression** — XP from distance, level-ups, and a hard-coded rank curve
- **Tactical attributes** — spend earned stat points on STR / AGI / VIT
- **Quests** — distance-based objectives that award bonus XP on completion
- **Hunt archive** — a persistent log of every cleared gate
- **Persistence** — hunter profile, quests, and run history survive app restarts
  via `shared_preferences`
- **Cyberpunk UI** — custom dark theme (`share tech mono` via `google_fonts`)

## Getting started

### Prerequisites

- Flutter 3.x (Dart SDK `^3.12.2`)
- An Android device/emulator (or a configured Android SDK to `flutter build apk`)

### Run

```bash
flutter pub get
flutter run
```

### Verify

```bash
flutter analyze   # expect: No issues found
flutter test      # expect: All tests passed
```

## Android setup

The app needs location permissions to track runs. These are already declared in
`android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

### Building a debug APK

If `flutter build apk --debug` reports "No Android SDK found", install the SDK
first:

1. Install [Android Studio](https://developer.android.com/studio) (it bundles the
   Android SDK).
2. On first launch, accept the SDK component installer.
3. Return to Flutter and configure the SDK location if it isn't auto-detected:
   ```bash
   flutter config --android-sdk "C:\Users\<your-user>\AppData\Local\Android\Sdk"
   ```
4. Confirm the toolchain is detected:
   ```bash
   flutter doctor
   ```
5. Build the APK:
   ```bash
   flutter build apk --debug
   ```
   The APK will be written to
   `build\app\outputs\flutter-apk\app-debug.apk`.

## Tests

- `test/widget_test.dart` — app launches and renders the splash screen
- `test/providers/persistence_test.dart` — hunter, quest, and run-log data
  round-trips through storage
- `test/providers/gameplay_test.dart` — quest XP and level-up / rank math