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

if git rev-parse --verify HEAD >/dev/null 2>&1; then
  COMMIT_MSG="$(git log -1 --pretty=format:%s)"
  echo "Checking latest commit message: $COMMIT_MSG"

  if [[ ! "$COMMIT_MSG" =~ ^(devops|patch|feat|fix|docs|style|refactor|perf|test|chore|revert|ci|build)(\(.+\))?:\ .+ ]]; then
    echo "❌ Commit message does not follow Conventional Commits specification."
    echo "Expected format: type(optional-scope): description"
    echo "Valid types: feat, fix, docs, style, refactor, perf, test, chore, revert, ci, build, devops, patch"
    exit 1
  fi

  SUBJECT="$(echo "$COMMIT_MSG" | sed -E 's/^[a-z]+(\([^)]+\))?: //')"
  if [[ -z "$SUBJECT" ]]; then
    echo "Commit subject may not be empty."
    exit 1
  fi

  if [[ "$SUBJECT" =~ \.$ ]]; then
    echo "Commit subject may not end with a period."
    exit 1
  fi

  if [[ ${#COMMIT_MSG} -gt 100 ]]; then
    echo "Warning: commit header is longer than 100 characters (${#COMMIT_MSG} chars)."
  fi

  echo "✅ Latest commit message is valid."
else
  echo "No previous commits found yet, skipping latest commit message check."
fi

echo "Running flutter analyze..."
flutter analyze

echo "Running flutter test..."
flutter test

echo "Pre-commit checks passed."
