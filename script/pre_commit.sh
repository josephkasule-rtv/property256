#!/usr/bin/env bash

set -euo pipefail

BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
echo "Checking branch name: $BRANCH_NAME"

if [[ ! "$BRANCH_NAME" =~ ^(devops|patch|feature|bugfix|hotfix|release|develop)/.+$ ]]; then
  echo "❌ Branch name does not follow Git Flow convention."
  echo "Expected patterns:"
  echo "  - feature/your-feature-name"
  echo "  - bugfix/your-bugfix-name"
  echo "  - hotfix/your-hotfix-name"
  echo "  - release/version-number"
  echo "  - develop/your-branch-name"
  exit 1
fi

echo "✅ Branch name is valid."

echo "Running flutter analyze..."
flutter analyze

echo "Running flutter test..."
flutter test

echo "Pre-commit checks passed."
