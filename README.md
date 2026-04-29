# Property256

Property256 is a Flutter MVP for property management in Kampala.

Current scope:
- Property listing screen
- Single property detail screen
- In-memory data source (no database yet)

## Prerequisites

- Flutter SDK installed (`flutter --version`)
- Dart SDK (bundled with Flutter)
- A simulator/emulator or connected device

## Setup

1. Install dependencies:

```bash
flutter pub get
```

2. Verify Flutter environment (optional but recommended):

```bash
flutter doctor
```

## Run the App

From the project root, run:

```bash
flutter run
```

If you have multiple devices connected, select one explicitly:

```bash
flutter run -d <device_id>
```

## Run Tests

Run all unit and widget tests:

```bash
flutter test
```

Run a single test file:

```bash
flutter test test/widget_test.dart
```

## Project Structure

The app uses a modular monolith + layered architecture:

- `lib/core/` - app-wide routing and theme
- `lib/features/property/domain/` - entities, repository contracts, use-cases
- `lib/features/property/data/` - models, in-memory datasource, repository implementation
- `lib/features/property/presentation/` - provider, screens, widgets
- `lib/shared/` - shared utilities
