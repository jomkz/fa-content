#!/usr/bin/env bash
# Prepend unreleased commits to CHANGELOG.md.
# Requires git-cliff: cargo install git-cliff  OR  dnf/brew install git-cliff
set -euo pipefail

git cliff --unreleased --prepend CHANGELOG.md
echo "CHANGELOG.md updated. Review, then commit:"
echo "  git commit -s -m 'chore: update changelog for release'"
