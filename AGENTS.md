# Repository Guidelines

## Project Structure & Module Organization
`tmux.conf` is the main source of truth for behavior, key tables, and status-bar logic. Keep functional changes there unless they are purely visual. Theme presets live in `theme/*.conf`; contributors should treat `theme/current.conf` as a local symlink or override, not a tracked source file. User-facing documentation is split into `README.md`, `tmux_conf_en.md`, and `tmux_conf_kr.md`. Popup key hints are maintained in `tmux_keys.txt`. Demo automation lives under `demo/`, with generated artifacts in `demo/output/`.

## Build, Test, and Development Commands
Use commands that match the repo’s local workflow:

- `tmux source-file ~/.config/tmux/tmux.conf` reloads the config in a running tmux session.
- `bash demo/run-demo.sh` starts an isolated demo server on its own socket and does not touch your normal tmux server.
- `bash demo/render-demo.sh` regenerates the demo assets in `demo/output/` and requires `vhs`, `tmux`, and optionally `ffmpeg`.
- `tmux -f ./tmux.conf start-server \; show-options -g >/dev/null \; kill-server` is a quick syntax smoke test before opening a PR.

## Coding Style & Naming Conventions
Match the existing style exactly: one tmux command per line, short explanatory comments above non-obvious blocks, and grouped sections such as “Pane mode” or “Session mode.” In shell scripts, keep `#!/usr/bin/env bash` plus `set -euo pipefail`, use uppercase names for exported configuration (`SOCKET`, `SESSION`), and use `snake_case` for helper functions like `type_in_pane`. Prefer additive, mode-oriented names such as `zellij-pane` and descriptive filenames like `one-half-dark.conf`.

## Testing Guidelines
There is no formal unit-test suite. Every behavior change should include a manual tmux reload check and, when relevant, a demo run with `bash demo/run-demo.sh`. Changes that affect rendering or docs-visible behavior should also be verified with `bash demo/render-demo.sh`. Keep generated outputs limited to intended tracked assets; `demo/output/tmux-zellij-style-demo.gif` is the only committed render target.

## Commit & Pull Request Guidelines
Recent history uses short, imperative commit subjects such as `Clarify how the zellij-style tmux workflow is meant to be adopted` and `Keep mouse word and line copies active after double and triple click`. Follow that pattern: explain the user-facing intent, not just the file touched. PRs should include a concise summary, testing notes, linked issues when applicable, and updated screenshots or GIFs when keybindings, popup hints, or theme-visible behavior changes.
