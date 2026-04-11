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

## What It Tries To Do

- Keep `Ctrl-b` as the raw tmux prefix
- Use `Ctrl-g` as the main zellij-like launcher
- Split actions into mode tables: pane, tab, resize, scroll, move, session
- Show the active key table in the status bar
- Keep global movement shortcuts available with `Ctrl-Alt-h/j/k/l`

This is not a full zellij clone. It is a tmux configuration that borrows the same mental model where possible.

## Files

- [tmux.conf](tmux.conf): the actual tmux configuration
- [tmux_conf.md](tmux_conf.md): full manual in Korean
- [tmux_keys.txt](tmux_keys.txt): quick popup help text

## Main Keys

- `Ctrl-g`: open the zellij-style launcher
- `Ctrl-b`: normal tmux prefix
- `Ctrl-g ?`: open the keymap hints popup
- `Ctrl-b R`: reload the config

## Modes

- `Ctrl-g p`: pane mode
- `Ctrl-g t`: tab mode
- `Ctrl-g r`: resize mode
- `Ctrl-g s`: scroll/copy mode
- `Ctrl-g m`: move mode
- `Ctrl-g o`: session mode

## Install

Copy the config into your tmux config path:

```bash
mkdir -p ~/.config/tmux
cp tmux.conf ~/.config/tmux/tmux.conf
cp tmux_keys.txt ~/.config/tmux/tmux_keys.txt
```

For tmux `< 3.2`, use legacy path instead:

```bash
cp tmux.conf ~/.tmux.conf
```

Reload from an existing tmux session:

```bash
tmux source-file ~/.config/tmux/tmux.conf
```

Or use:

```text
Ctrl-b R
```

## Notes

- `tmux` cannot fully reproduce floating panes, pinned panes, or zellij's plugin UI
- Some `Ctrl-Alt-*` bindings depend on terminal emulator support
- The popup help expects `tmux_keys.txt` to live at `~/.config/tmux/tmux_keys.txt`

## Shareable Repo Shape

This directory is already close to a standalone repo. For GitHub publishing, the main remaining choices are:

- repository name
- public vs private visibility
- license
