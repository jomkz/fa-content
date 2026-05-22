# fa-content — FA Bridge Plugin

FA Bridge Plugin for [fighters-legacy](https://github.com/jomkz/fighters-legacy). Implements the `IContentPack` interface using [fx_lib](https://github.com/jomkz/fighters-codex) to translate Jane's Fighters Anthology (1998) asset formats into the engine's runtime types.

## What this is

fighters-legacy is a clean-room GPL v3 reimplementation of the combat flight simulator engine. It has no knowledge of FA-specific formats — all content enters through `IContentPack`. This repository is one implementation of that interface that bridges a user-supplied FA installation to the engine.

**You must own a legitimate copy of Jane's Fighters Anthology to use this plugin.** No FA game assets are included or may be committed to this repository.

## Dependencies

| Dependency | Source |
|---|---|
| fighters-legacy | Engine interface headers (`IContentPack.h`) |
| fx_lib | `extern/fx_lib` submodule from [fighters-codex](https://github.com/jomkz/fighters-codex) |

## Quick start

```bash
git clone --recurse-submodules https://github.com/jomkz/fa-content.git
cmake --preset debug
cmake --build --preset debug
```

See [docs/development.md](docs/development.md) for full prerequisites and build instructions.

## License

GPL v3. See [LICENSE](LICENSE).

Asset files (textures, audio, 3D models) will be licensed separately under CC-BY-SA 4.0 when a free base pack is included in a future phase. See `docs/content-license.md` when available.

> **Never commit FA game assets** (*.LIB, *.PIC, *.PAL, *.FLT, *.SHP, *.VXA). They are owned by Electronic Arts and are not covered by this project's license.
