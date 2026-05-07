#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOOKS_DIR="$ROOT_DIR/.git/hooks"
SOURCE_PRE_COMMIT="$ROOT_DIR/script/pre_commit.sh"
SOURCE_COMMIT_MSG="$ROOT_DIR/script/commit_msg.sh"
TARGET_PRE_COMMIT="$HOOKS_DIR/pre-commit"
TARGET_COMMIT_MSG="$HOOKS_DIR/commit-msg"

if [[ ! -d "$ROOT_DIR/.git" ]]; then
  echo "Error: .git directory not found. Run this from a git repository clone."
  exit 1
fi

chmod +x "$SOURCE_PRE_COMMIT" "$SOURCE_COMMIT_MSG"
mkdir -p "$HOOKS_DIR"
cp "$SOURCE_PRE_COMMIT" "$TARGET_PRE_COMMIT"
cp "$SOURCE_COMMIT_MSG" "$TARGET_COMMIT_MSG"
chmod +x "$TARGET_PRE_COMMIT" "$TARGET_COMMIT_MSG"

echo "Installed hooks:"
echo "- $TARGET_PRE_COMMIT"
echo "- $TARGET_COMMIT_MSG"
