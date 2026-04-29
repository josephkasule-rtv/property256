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

## Pre-commit Checks

This repository uses a native Git pre-commit hook script (no global package install required).

Configured checks:
- Branch naming convention
- Latest commit message convention
- `flutter analyze`
- `flutter test`

### One-time Setup

Install the Git hook (recommended):

```bash
make hooks-install
```

This command:
- ensures `script/pre_commit.sh` is executable
- installs `.git/hooks/pre-commit`
- makes the installed hook executable

You can still run the script manually if needed:

### Manual Run

Run the same checks manually:

```bash
make hooks-run
```

### Naming Conventions Enforced Locally

Branch names must follow one of these prefixes:
- `feature/`
- `bugfix/`
- `hotfix/`
- `release/`
- `develop/`
- `devops/`
- `patch/`

Examples:
- `feature/property-card-redesign`
- `bugfix/detail-screen-null-state`
- `develop/integration-tests`

Latest commit message must follow:
- `type(optional-scope): description`

Allowed types:
- `devops`, `patch`, `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `revert`, `ci`, `build`

Examples:
- `feat: add property filters`
- `fix(detail): handle empty property state`
- `docs(readme): clarify local hook setup`

### Commit Behavior

- A commit is blocked if branch naming does not follow allowed prefixes.
- A commit is blocked if latest commit message does not match allowed format.
- A commit is blocked if `flutter analyze` fails.
- A commit is blocked if `flutter test` fails.
- Fix the issues and commit again.

## SonarCloud Pipeline

This project includes a dedicated GitHub Actions workflow for SonarCloud static analysis:
- `.github/workflows/sonarcloud.yml`

What it does:
- runs on push and pull request for `main` and `develop`
- executes `flutter test --coverage`
- sends analysis to SonarCloud
- posts/updates a PR comment with Sonar quality gate and key metrics

Required GitHub repository secrets:
- `SONAR_TOKEN`: SonarCloud token with permission to analyze this project

GitHub-provided token:
- `GITHUB_TOKEN` is used automatically by GitHub Actions for PR decoration
