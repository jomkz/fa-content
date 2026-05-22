# Architecture Overview

fa-content is a bridge plugin that implements the `IContentPack` interface from [fighters-legacy](https://github.com/jomkz/fighters-legacy). It translates Jane's Fighters Anthology (1998) asset formats into the engine's runtime types using the FA format parsers in [fx_lib](https://github.com/jomkz/fighters-codex).

The engine has no knowledge of FA, this repository, or any specific game. All it knows is `IContentPack`.

---

## Data flow

```
FA Install (user-supplied, *.LIB / *.PIC / *.PAL / *.FLT / ...)
    │
    ▼
extern/fx_lib   (fighters-codex submodule — FA format parsers)
    │  parse / decode raw FA binary formats
    ▼
bridge/         (IContentPack implementation)
    │  loadMesh(), loadTexture(), loadAudio(), loadMission(), ...
    ▼
Engine AssetManager   (fighters-legacy)
    │
    ▼
Game runtime
```

---

## Key modules

### `bridge/`

Implements `IContentPack`. Each `load*()` method:
1. Locates the relevant file(s) in `FA_INSTALL_DIR`
2. Calls the appropriate fx_lib parser to decode the FA binary format
3. Returns the result as the engine's platform-independent asset type

A translation cache sits between fx_lib and the engine — decoded assets are cached on first load so repeated requests (e.g. a texture used by many models) don't re-parse the source file each time.

### `assets/`

Asset translation pipeline for more complex conversions: mesh format normalisation, palette expansion for indexed PIC textures, audio resampling. Used internally by `bridge/` where a single fx_lib call is not sufficient.

### `extern/fx_lib`

Git submodule from [fighters-codex](https://github.com/jomkz/fighters-codex). Provides low-level parsers for FA binary formats. The bridge layer calls fx_lib; fa-content does not duplicate parser logic.

---

## Design constraints

- **One-way bridge.** The engine calls `IContentPack`; it never links against this repo or fx_lib directly. The dependency arrow points inward only.
- **No FA assets in the repo.** All FA content is sourced at runtime from the user-supplied FA installation. The `.gitignore` blocks all FA file extensions.
- **fx_lib is a submodule, not vendored.** Updates to the FA format parsers in fighters-codex are picked up by updating the submodule pointer — no duplication.
- **`FA_INSTALL_DIR` is required at runtime, not build time.** The bridge builds without an FA installation present; tests that need real FA data are skipped when `FA_INSTALL_DIR` is unset.
