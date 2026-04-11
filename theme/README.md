# tmux themes

These files override the theme-specific style settings used by [tmux.conf](../tmux.conf).

## Bundled themes

- `atom-one-dark.conf`
- `atom-one-light.conf`
- `catppuccin-latte.conf`
- `catppuccin-mocha.conf`
- `dracula.conf`
- `gruvbox-dark.conf`
- `nord.conf`
- `one-half-dark.conf`
- `one-half-light.conf`
- `solarized-dark.conf`

## Selection

`tmux.conf` loads themes like this:

1. `~/.config/tmux/theme/current.conf` if it exists
2. otherwise `~/.config/tmux/theme/one-half-dark.conf`

Recommended switch pattern:

```bash
ln -sf ~/.config/tmux/theme/dracula.conf ~/.config/tmux/theme/current.conf
tmux source-file ~/.config/tmux/tmux.conf
```

## Codex CLI overlap

The installed Codex CLI binary in this environment contains these built-in theme names:

- `catppuccin-latte`
- `catppuccin-mocha`
- `dracula`
- `gruvbox-dark`
- `nord`
- `one-half-dark`
- `one-half-light`
- `solarized-dark`
- `ansi`

This repo also includes `atom-one-dark` and `atom-one-light` because they are widely recognized and fit the same ecosystem well.
