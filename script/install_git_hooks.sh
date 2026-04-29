#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOOKS_DIR="$ROOT_DIR/.git/hooks"
SOURCE_HOOK="$ROOT_DIR/script/pre_commit.sh"
TARGET_HOOK="$HOOKS_DIR/pre-commit"

if [[ ! -d "$ROOT_DIR/.git" ]]; then
  echo "Error: .git directory not found. Run this from a git repository clone."
  exit 1
fi

chmod +x "$SOURCE_HOOK"
mkdir -p "$HOOKS_DIR"
cp "$SOURCE_HOOK" "$TARGET_HOOK"
chmod +x "$TARGET_HOOK"

echo "Installed pre-commit hook at: $TARGET_HOOK"
