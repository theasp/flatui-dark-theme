# Agent Configuration

**Generated:** 2026-11-17
**Commit:** 3cf2c1d
**Branch:** master

## OVERVIEW

flatui-dark-theme is a single-file Emacs color theme, rebuilt on the
[modus-themes](https://github.com/protesilaos/modus-themes) engine. Instead of
defining ~550 faces by hand, it declares a complete FlatUI palette
(https://flatuicolors.com/) and lets `modus-themes-theme` generate the full
face set from it. The theme is `flatui-dark-modus` and lives in
`flatui-dark-theme.el`.

There is no build step and no test suite. The theme requires `modus-themes`
>= 5.0.0.

## STRUCTURE

```
flatui-dark-theme/
├── AGENTS.md                    # This file
├── changelog.org                # Release changelog (org-mode, Keep a Changelog format)
├── flatui-dark-theme.el         # The theme — palette + modus-themes-theme call
├── flatui-dark-theme-test.el    # ERT test suite
├── README.org                   # Project readme (org-mode)
├── screenshot1.png              # Screenshot referenced by the readme
└── LICENSE                      # GNU GPL v2+
```

## Requirements

- Emacs 29.1+
- [modus-themes](https://github.com/protesilaos/modus-themes) 5.0.0+
  (the version that provides the theme-building API `modus-themes-theme`)

## Build / Verification Commands

There is no build step. Verify the theme with the ERT test suite
**with modus-themes available** (it must be on the load path, e.g. from
MELPA's `elpa/modus-themes-<ver>/`):

```bash
emacs --batch -L <modus-themes-dir> -l flatui-dark-theme-test.el \
  --eval "(ert-run-tests-batch-and-exit)"
```

The tests load the theme and check that it activates, is registered in
`modus-themes-registered-items`, that every face's `:inherit` parent is a
valid face (the modus-themes `inheritance` test pattern), and that the
FlatUI palette is complete. If `modus-themes` is not installed, the suite
fails at `(require 'modus-themes)` — that is the missing dependency, not a
theme bug. Install it (e.g. via MELPA) first.

Run the test suite before any release; abort if it fails.

## Code Conventions

- Single file. The theme is one `modus-themes-theme` call driven by the
  `flatui-dark-modus-palette` constant.
- All colors come from the FlatUI palette, declared in
  `flatui-dark-modus-palette` (a `defconst` built on
  `modus-themes-common-palette-mappings`). Faces reference palette symbols
  (e.g. `fg1`, `bg2`, `keyword`), never raw hex strings.
- User-facing extension points: `flatui-dark-modus-palette-user` (add colors)
  and `flatui-dark-modus-palette-overrides` (override colors), both `defcustom`.
- Keep the `lexical-binding: t` file cookie (line 1).
- The `Package-Requires: ((emacs "29.1") (modus-themes "5.0.0"))` header is
  what MELPA reads for the minimum Emacs version and the `modus-themes`
  dependency; keep it in sync with the real minimums.

## Release Process

MELPA builds this package from git tags: **the tag name is the version**.
There is no version file to bump (no `Cargo.toml`, no version `defvar`) — the
theme file carries no version string.

Only release when the user explicitly asks for it. Permission is one-time; ask
every time.

1. Run the ERT test suite (see Build / Verification Commands); abort the
   release if it fails.
2. `git status; git diff` to catch all changes; check `.gitignore`.
3. Move the `changelog.org` `[Unreleased]` entries into a
   `[X.Y.Z] - YYYY-MM-DD` section; add a new empty `[Unreleased]` above it.
4. Commit all changes (changelog + theme) in one commit.
5. Create a semver tag matching the new changelog version: `git tag X.Y.Z`.
   Never reuse a version number.
6. `git push origin master X.Y.Z`. No force push, no reused versions.
7. MELPA's build farm picks up the pushed tag and republishes (installing
   `modus-themes` as a declared dependency); the new version appears on
   melpa.org within a few minutes. No further action is needed.

Version increments:

- **Patch** (X.Y.Z → X.Y.(Z+1)): palette/color tweaks, small fixes.
- **Minor** (X.Y → X.(Y+1).0): new palette entries / feature additions.
- **Major**: a breaking change (theme rename, raised Emacs/modus-themes minimums).

## Changelog

The project uses [Keep a Changelog](https://keepachangelog.com/). The changelog
lives at `changelog.org` in the project root (org-mode; version headings are
`* [X.Y.Z] - YYYY-MM-DD` with `** Added` / `** Changed` / `** Fixed` /
`** Removed` subsections).

- **Always update `changelog.org`** when making changes that affect users (new
  palette entries, color changes, breaking changes, bug fixes).
- Add entries under the `[Unreleased]` section using these categories: `Added`,
  `Changed`, `Deprecated`, `Removed`, `Fixed`, `Security` (and `Breaking` for
  breaking changes).
- Keep descriptions concise and user-focused — what changed from the user's
  perspective, not implementation details.
- Commit changelog updates in the same commit as the change they document.
- Before releasing, move `[Unreleased]` entries to a versioned section
  (e.g. `[1.0.0] - YYYY-MM-DD`) and add a new empty `[Unreleased]` above it.
