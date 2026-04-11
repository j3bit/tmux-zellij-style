# tmux-zellij-style

Use `tmux` with a more `zellij`-like flow.

This repo keeps the original tmux power model, but adds a launcher-oriented keymap so pane, tab, resize, move, scroll, and session actions feel closer to zellij.

## Version Requirement

Automatic loading from `~/.config/tmux/tmux.conf` requires tmux `3.2` or newer.

tmux `3.2` added support for trying:

- `$XDG_CONFIG_HOME/tmux/tmux.conf`
- `~/.config/tmux/tmux.conf`

Older tmux versions primarily expect `~/.tmux.conf`, so if you are on tmux `< 3.2`, either:

- copy this config to `~/.tmux.conf`, or
- start tmux with `-f ~/.config/tmux/tmux.conf`

## Install

Clone the repo into your tmux config path:

```bash
git clone https://github.com/j3bit/tmux-zellij-style.git ~/.config/tmux
```

If you already have a different tmux repo or dotfiles layout, you can also clone elsewhere and symlink the main config directory:

```bash
git clone https://github.com/j3bit/tmux-zellij-style.git ~/path/to/tmux-zellij-style
mkdir -p ~/.config
ln -sfn ~/path/to/tmux-zellij-style ~/.config/tmux
```

For tmux `< 3.2`, use the legacy config path instead:

```bash
ln -sfn ~/.config/tmux/tmux.conf ~/.tmux.conf
```

Avoid managing both `~/.tmux.conf` and `~/.config/tmux/tmux.conf` with different contents at the same time.

On modern tmux, both files may be loaded, and overlapping settings can override each other. If you already have a `~/.tmux.conf`, the safest options are:

- keep only one real config source, or
- reduce `~/.tmux.conf` to a simple handoff such as `source-file ~/.config/tmux/tmux.conf`

Reload from an existing tmux session:

```bash
tmux source-file ~/.config/tmux/tmux.conf
```

Or use session mode:

```text
Ctrl-g o r
```

## What It Tries To Do

- Keep `Ctrl-b` as the raw tmux prefix
- Use `Ctrl-g` as the main zellij-like launcher
- Split actions into mode tables: pane, tab, resize, scroll, move, session
- Show the active key table in the status bar
- Keep global movement shortcuts available with `Ctrl-Alt-h/j/k/l`

This is not a full zellij clone. It is a tmux configuration that borrows the same mental model where possible.

## Files

- [tmux.conf](tmux.conf): the actual tmux configuration
- [tmux_conf_kr.md](tmux_conf_kr.md): full manual in Korean
- [tmux_conf_en.md](tmux_conf_en.md): full manual in English
- [tmux_keys.txt](tmux_keys.txt): quick popup help text
- [theme/](theme): reusable tmux theme files

## Main Keys

- `Ctrl-g`: open the zellij-style launcher
- `Ctrl-b`: normal tmux prefix
- `Ctrl-g ?`: open the keymap hints popup
- `Ctrl-g o r`: reload the config from session mode

## Themes

This repo now separates layout/behavior from color themes.

Bundled tmux themes:

- `catppuccin-latte`
- `catppuccin-mocha`
- `dracula`
- `gruvbox-dark`
- `nord`
- `one-half-dark`
- `one-half-light`
- `solarized-dark`

Codex CLI overlap confirmed locally from the installed `codex` binary:

- `catppuccin-latte`
- `catppuccin-mocha`
- `dracula`
- `gruvbox-dark`
- `nord`
- `one-half-dark`
- `one-half-light`
- `solarized-dark`

### Theme selection strategy

`tmux.conf` uses this rule:

- if `~/.config/tmux/theme/current.conf` exists, source that
- otherwise fall back to `~/.config/tmux/theme/one-half-dark.conf`

That makes theme switching simple and keeps `tmux.conf` stable.

Example:

```bash
ln -sf ~/.config/tmux/theme/dracula.conf ~/.config/tmux/theme/current.conf
tmux source-file ~/.config/tmux/tmux.conf
```

## Modes

- `Ctrl-g p`: pane mode
- `Ctrl-g t`: tab mode
- `Ctrl-g r`: resize mode
- `Ctrl-g s`: scroll/copy mode
- `Ctrl-g m`: move mode
- `Ctrl-g o`: session mode

## Notes

- `tmux` cannot fully reproduce floating panes, pinned panes, or zellij's plugin UI
- Some `Ctrl-Alt-*` bindings depend on terminal emulator support
- The popup help expects `tmux_keys.txt` to live at `~/.config/tmux/tmux_keys.txt`

## Shareable Repo Shape

This directory is already close to a standalone repo. For GitHub publishing, the main remaining choices are:

- repository name
- public vs private visibility
- license
