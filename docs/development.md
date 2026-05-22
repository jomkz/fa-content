# Development Guide

## Prerequisites

### Linux — Fedora (primary maintainer platform)

```bash
sudo dnf install cmake ninja-build gcc g++ clang clang-tools-extra lcov
```

### Linux — Ubuntu/Debian

```bash
sudo apt-get update
sudo apt-get install -y cmake ninja-build gcc g++ clang clang-format lcov
```

### Windows (MSVC 2022)

1. Install [Visual Studio 2022](https://visualstudio.microsoft.com/) with the **Desktop development with C++** workload
2. Optional: install Ninja via `winget install Ninja-build.Ninja`

### macOS (Apple Silicon, 13+)

```bash
xcode-select --install
brew install cmake ninja
```

For platform-specific fighters-legacy prerequisites (Vulkan SDK, SDL3, OpenAL Soft), see [fighters-legacy/docs/development.md](https://github.com/jomkz/fighters-legacy/blob/main/docs/development.md).

---

## First-time setup

```bash
git clone --recurse-submodules https://github.com/jomkz/fa-content.git
cd fa-content
```

If you already cloned without `--recurse-submodules`:

```bash
git submodule update --init --recursive
```

This pulls `extern/fx_lib` from fighters-codex — the FA format parser library.

---

## Building

```bash
# Linux / macOS
cmake --preset debug
cmake --build --preset debug

# Windows (PowerShell)
cmake --preset debug-msvc
cmake --build --preset debug-msvc
```

### Running tests

```bash
ctest --preset debug --output-on-failure
```

---

## Runtime testing against a real FA installation

Set `FA_INSTALL_DIR` to point at your FA installation directory before running integration tests:

```bash
export FA_INSTALL_DIR="/path/to/Janes Fighters Anthology"
ctest --preset debug --output-on-failure
```

On Windows (PowerShell):

```powershell
$env:FA_INSTALL_DIR = "C:\Games\Janes Fighters Anthology"
ctest --preset debug-msvc --output-on-failure
```

Tests that require a real FA installation are skipped if `FA_INSTALL_DIR` is not set. CI runs without it; only the unit and integration tests that operate on bundled test fixtures run in CI.

---

## Git setup

Install the commit-msg hook to auto-append `Signed-off-by` (DCO requirement):

```bash
cp scripts/hooks/commit-msg .git/hooks/
chmod +x .git/hooks/commit-msg
```

---

## Local preset overrides

Create `CMakeUserPresets.json` in the repo root to override preset defaults (e.g. a different build directory or custom toolchain). This file is gitignored.

---

## Code coverage (optional — CI handles this automatically)

```bash
cmake --preset coverage
cmake --build --preset coverage
ctest --preset coverage --output-on-failure
lcov --capture --directory . --output-file coverage.info
lcov --remove coverage.info '/usr/*' '*/tests/*' '*/vendor/*' \
     --output-file coverage.info
```

---

## Release workflow

Releases are tagged with `vMAJOR.MINOR.PATCH`. To draft the changelog before tagging:

```bash
./scripts/draft-changelog.sh
```

Requires `git-cliff`: `cargo install git-cliff` or `dnf install git-cliff` or `brew install git-cliff`.
