#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: commit_msg.sh <commit-msg-file | commit-message>"
  exit 1
fi

INPUT="$1"
if [[ -f "$INPUT" ]]; then
  COMMIT_MSG="$(head -n 1 "$INPUT")"
else
  COMMIT_MSG="$INPUT"
fi

echo "Checking commit message: $COMMIT_MSG"

if [[ "$COMMIT_MSG" =~ ^Merge ]]; then
  echo "Skipping merge commit validation."
  exit 0
fi

if [[ ! "$COMMIT_MSG" =~ ^(devops|patch|feat|fix|docs|style|refactor|perf|test|chore|revert|ci|build)(\(.+\))?:\ .+ ]]; then
  echo "Commit message does not follow Conventional Commits specification."
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

echo "Commit message is valid."
