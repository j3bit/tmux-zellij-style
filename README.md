# tmux-zellij-style

**tmux, but with a more zellij-like flow.**

If you like tmux's power but miss zellij's “enter a mode, then do a thing” feel, this config is for you.

It keeps raw tmux intact, but adds a launcher-driven workflow for panes, tabs, resizing, scrolling, moving, sessions, and theme selection.

## Why (the hell) this exists

Truthfully, I am more of a zellij person.

I genuinely prefer zellij's interaction philosophy: enter a mode, do a thing, get out. It feels cleaner in my head than stock tmux, which can sometimes feel a little too prefix-and-punctuation heavy.

But after enough real use, especially with AI-agent-heavy workflows like Codex CLI, I kept running into the same conclusion:

- I liked zellij's UX more
- I trusted tmux's behavior more

tmux is not always prettier, and it is definitely not more charming, but it has a reputation for being boring in the best possible way: stable, scriptable, predictable, and very hard to knock over.

So this config is basically the compromise I actually wanted:

> keep tmux's reliability, steal as much of zellij's "enter a mode, then do a thing" mental model as possible

Instead of giving up on zellij's philosophy, I tried to bring that philosophy into a tmux setup I could trust under heavier, messier, more automation-driven use.

In practice, that means instead of memorizing a pile of unrelated bindings, you mostly think like this:

- `Ctrl-g` → “what kind of thing do I want to do?”
- `p` / `t` / `r` / `s` / `m` / `o` → “pane / tab / resize / scroll / move / session”
- then one more key for the action

`Ctrl-b` still works as normal tmux prefix. Nothing is taken away. This just adds a more structured top layer.

## Who this is for

This setup is a good fit if you:

- like tmux but want a more mode-oriented workflow
- use zellij and want some of that feel in tmux
- want fast pane and tab actions without remembering too many raw tmux bindings
- want a small, readable tmux config instead of a huge plugin-heavy setup

This is **not** trying to be a full zellij clone. Floating panes, pinned panes, and richer zellij UI concepts are still outside tmux's model.

## At a glance

| | Stock tmux | this config | zellij |
| --- | --- | --- | --- |
| Core engine | tmux | tmux | zellij |
| Main interaction style | raw prefix bindings | launcher + modes on top of tmux | built-in mode workflow |
| Raw tmux compatibility | native | preserved | no |
| Pane / tab workflow | powerful but lower-level | faster to remember | native |
| Floating panes | no | no | yes |
| Pinned panes | no | no | yes |
| Plugin / UI ecosystem | tmux-style | tmux-style | zellij-style |
| Best fit | tmux purists | tmux users who want zellij-like flow | users who want full zellij model |

## Install

Clone the repo into your tmux config path:

```bash
git clone https://github.com/j3bit/tmux-zellij-style.git ~/.config/tmux
```

If you already manage tmux elsewhere in your dotfiles, clone it anywhere you want and symlink the directory:

```bash
git clone https://github.com/j3bit/tmux-zellij-style.git ~/path/to/tmux-zellij-style
mkdir -p ~/.config
ln -sfn ~/path/to/tmux-zellij-style ~/.config/tmux
```

Reload from an existing tmux session:

```bash
tmux source-file ~/.config/tmux/tmux.conf
```

## Version Requirement

Automatic loading from `~/.config/tmux/tmux.conf` requires tmux `3.2` or newer.

tmux `3.2` added support for:

- `$XDG_CONFIG_HOME/tmux/tmux.conf`
- `~/.config/tmux/tmux.conf`

For tmux `< 3.2`, use the legacy path instead:

```bash
ln -sfn ~/.config/tmux/tmux.conf ~/.tmux.conf
```

Also, avoid managing both `~/.tmux.conf` and `~/.config/tmux/tmux.conf` with different contents at the same time.

On modern tmux, both may be loaded, so overlapping settings can override each other. If you already have a `~/.tmux.conf`, the safest options are:

- keep only one real config source, or
- reduce `~/.tmux.conf` to a simple handoff such as `source-file ~/.config/tmux/tmux.conf`

## First 30 seconds

Try these in order:

- Split right: `Ctrl-g p r`
- Split down: `Ctrl-g p d`
- Move between panes: `Ctrl-g p h/j/k/l`
- Open a new tab: `Ctrl-g t n`
- Resize a pane: `Ctrl-g r h/j/k/l`
- Copy from scrollback: `Ctrl-g s`, then `v`, then `y`

If that already feels more natural than stock tmux, then the config is doing its job.

## Usage Model

This config keeps normal tmux available, but puts a zellij-style launcher on top.

- `Ctrl-b` stays as the normal tmux prefix
- `Ctrl-g` opens the launcher
- after `Ctrl-g`, choose one area of work: pane, tab, resize, scroll, move, or session
- the active mode is shown in the status bar
- global pane movement is also available with `Ctrl-Alt-h/j/k/l` and arrow-key variants

In short:

- **tmux muscle stays**
- **workflow gets cleaner**

## Main Keys

- `Ctrl-g`: open the launcher
- `Ctrl-b`: use raw tmux bindings
- `Ctrl-g ?`: open the keymap hints popup
- `Ctrl-g q`: detach current client
- `Ctrl-g Q`: confirm kill for current session
- `Ctrl-g o r`: reload `tmux.conf`

## Modes

After pressing `Ctrl-g`, use:

- `p`: pane mode for splitting, focusing, zooming, renaming, and closing panes
- `t`: tab mode for switching, creating, renaming, reordering, and closing windows
- `r`: resize mode for changing pane size
- `s`: scroll and copy mode using tmux copy-mode with vi keys
- `m`: move mode for swapping panes and rotating layouts
- `o`: session mode for detach, rename, chooser, and reload actions

## Quick Start Patterns

Common flows you will probably use every day:

- Create a simple split layout: `Ctrl-g p r` then `Ctrl-g p d`
- Move between panes: `Ctrl-g p h/j/k/l` or `Ctrl-Alt-h/j/k/l`
- Toggle zoom on the current pane: `Ctrl-g p f`
- Open a new tab: `Ctrl-g t n`
- Jump back to the previous pane: `Ctrl-g p Tab`
- Jump back to the previous tab: `Ctrl-g t Tab`
- Resize a pane: `Ctrl-g r h/j/k/l`
- Copy from scrollback: `Ctrl-g s`, then `v`, then `y`
- Move pane positions: `Ctrl-g m h/j/k/l`

## Themes

This repo keeps behavior in `tmux.conf` and color styling in `theme/*.conf`.

Included themes:

- `catppuccin-latte`
- `catppuccin-mocha`
- `dracula`
- `gruvbox-dark`
- `nord`
- `one-half-dark`
- `one-half-light`
- `solarized-dark`

All of them are also familiar Codex CLI theme names, so it is easy to keep your tmux chrome and Codex CLI in roughly the same visual family.

### Theme selection strategy

`tmux.conf` uses this rule:

- if `~/.config/tmux/theme/current.conf` exists, source that
- otherwise fall back to `~/.config/tmux/theme/one-half-dark.conf`

That keeps theme switching simple without touching the main keymap file.

Example:

```bash
ln -sf ~/.config/tmux/theme/dracula.conf ~/.config/tmux/theme/current.conf
tmux source-file ~/.config/tmux/tmux.conf
```

If you do nothing, the default fallback is `one-half-dark`.

## Files

- [tmux.conf](tmux.conf): the main tmux config
- [tmux_conf_kr.md](tmux_conf_kr.md): full manual in Korean
- [tmux_conf_en.md](tmux_conf_en.md): full manual in English
- [tmux_keys.txt](tmux_keys.txt): popup keymap hints
- [theme/](theme): reusable theme files

## Notes

- `tmux` cannot fully reproduce floating panes, pinned panes, or zellij's plugin UI
- some `Ctrl-Alt-*` bindings depend on terminal emulator support
- the popup help expects `tmux_keys.txt` to live at `~/.config/tmux/tmux_keys.txt`
