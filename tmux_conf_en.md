# tmux zellij-style manual

Reference file: [tmux.conf](tmux.conf)

This setup aims to make `tmux` feel more like `zellij`. It does not try to turn tmux into a perfect clone, but it does try to bring the everyday flow and hand feel much closer.

## Core idea

This setup splits key input into two layers.

1. `Ctrl-g`
   This is the main launcher key, similar to entering a mode in zellij. Press `Ctrl-g` first, then choose the mode you want.

2. `Ctrl-b`
   This remains the normal tmux prefix. It is kept as the raw tmux escape hatch, separate from the zellij-style keymap.

In practice, you can think about it like this:

- `Ctrl-g`: main zellij-style launcher
- `Ctrl-b`: normal tmux prefix
- `Ctrl-g ?`: custom keymap hints popup
- `Ctrl-g q`: detach current client
- `Ctrl-g Q`: confirm kill for current session

## Quick start

If you open a new tmux session, the config applies immediately.

To reload it inside an existing session, run:

```bash
tmux source-file ~/.config/tmux/tmux.conf
```

Or use session mode:

```text
Ctrl-g o r
```

To open the custom keymap hints popup quickly, press:

```text
Ctrl-g ?
```

That binding opens [tmux_keys.txt](tmux_keys.txt) in a popup.

The right side of the top status bar shows the current key table name.

- `mode:root`: normal state
- `mode:zellij-pane`: pane mode
- `mode:zellij-tab`: tab mode

## zellij-style mental model

This config brings zellij's "enter a mode first, then choose an action" flow into tmux.

The rough mapping looks like this:

| zellij feel | tmux mapping |
| --- | --- |
| `Ctrl-g` then `p` | pane mode |
| `Ctrl-g` then `t` | tab mode |
| `Ctrl-g` then `r` | resize mode |
| `Ctrl-g` then `s` | scroll/copy mode |
| `Ctrl-g` then `m` | move mode |
| `Ctrl-g` then `o` | session mode |
| `Ctrl-g` then `?` | custom keymap hints popup |
| `Ctrl-g` then `q` | detach current client |
| `Ctrl-g` then `Q` | confirm kill for current session |

## Global keys that always work

These keys work without entering any mode first.

### Focus movement

- `Ctrl-Alt-Left` or `Ctrl-Alt-h`: move to the left pane
- `Ctrl-Alt-Right` or `Ctrl-Alt-l`: move to the right pane
- `Ctrl-Alt-Up` or `Ctrl-Alt-k`: move to the pane above
- `Ctrl-Alt-Down` or `Ctrl-Alt-j`: move to the pane below

Behavior notes:

- Moving left at the far edge jumps to the previous window.
- Moving right at the far edge jumps to the next window.
- Up and down do not cross windows.

### Create a new pane

- `Ctrl-Alt-n`: split downward using the current pane path

## How to enter modes

The main flow is:

```text
Ctrl-g -> p/t/r/s/m/o
```

Direct exit actions:

```text
Ctrl-g q   -> detach
Ctrl-g Q   -> kill current session (confirm)
```

To leave a mode, use:

- `Enter`
- `Esc`
- `Ctrl-g`

Most action-oriented bindings automatically return to `root` after they run. This also helps the setup feel closer to zellij.

---

## 1. Pane mode

Enter:

```text
Ctrl-g p
```

### Movement

- `h j k l`
- arrow keys `← ↓ ↑ →`
- `Tab`: jump to the previous pane

### Actions

- `c`: rename the current pane title
- `d`: split downward
- `n`: split downward
- `r`: split right
- `f`: toggle zoom on the current pane
- `s`: switch to tiled layout
- `x`: kill the current pane
- `z`: toggle pane border title visibility
- `p`: return to the normal launcher

### Differences from zellij

- `e`: tmux cannot toggle embed/floating panes, so this shows a message only.
- `i`: there is no pinned pane concept.
- `w`: there is no floating pane layer.

### Recommended usage

- Split panes: `Ctrl-g p d` or `Ctrl-g p r`
- Move across panes: `Ctrl-g p h/j/k/l`
- Zoom the current pane: `Ctrl-g p f`
- Close a pane: `Ctrl-g p x`

---

## 2. Tab mode

Enter:

```text
Ctrl-g t
```

In tmux, zellij-style tabs map to windows.

### Movement

- `h` or `Left`: previous tab
- `j` or `Right`: next tab
- `k` or `Up`: previous tab
- `l` or `Down`: next tab
- `Tab`: return to the previous tab

### Direct selection

- `1` through `9`: jump to that tab number

Window indexing starts at `1` in this config.

### Actions

- `n`: create a new tab
- `r`: rename the current tab
- `x`: kill the current tab
- `s`: toggle synchronize-panes
- `b`: break the current pane into a new tab
- `[`: move the current tab left
- `]`: move the current tab right
- `t`: return to the normal launcher

### Recommended usage

- New tab: `Ctrl-g t n`
- Rename: `Ctrl-g t r`
- Reorder: `Ctrl-g t [` or `Ctrl-g t ]`
- Jump to a specific tab: `Ctrl-g t 3`

---

## 3. Resize mode

Enter:

```text
Ctrl-g r
```

### Resize

- `h`: expand to the left
- `j`: expand downward
- `k`: expand upward
- `l`: expand to the right

Arrow keys work as well.

### Reverse-direction shrink feel

Uppercase bindings are included to mimic zellij's directional feel:

- `H`
- `J`
- `K`
- `L`

That said, tmux implements this by moving pane borders, so it does not feel exactly the same as zellij.

### Exit

- `r`: return to the normal launcher
- `Enter`
- `Esc`
- `Ctrl-g`

---

## 4. Scroll / Copy mode

Enter:

```text
Ctrl-g s
```

This drops you directly into tmux `copy-mode`. The mode does not exit automatically just because you scroll to the bottom.

### Movement

The default feel is vi-style:

- `h j k l`
- arrow keys
- `PageUp`
- `PageDown`

### Select / copy

- `v`: begin selection
- `y`: copy selection and exit
- `Esc`: exit copy mode
- `q`: exit copy mode

Because `set-clipboard on` is enabled, clipboard integration can work with the system clipboard if your terminal and OS support it.

---

## 5. Move mode

Enter:

```text
Ctrl-g m
```

Use this mode when you want to physically rearrange pane positions.

### Pane swap

- `h j k l`
- arrow keys

The active pane swaps with the adjacent pane in that direction. Focus stays on the active pane after the swap.

### Rotate

- `n`: rotate down
- `p`: rotate up
- `Tab`: rotate down

### Exit

- `m`: return to the normal launcher
- `Enter`
- `Esc`
- `Ctrl-g`

### Note

If you try to swap toward a missing pane at the edge, tmux may briefly show an error message. That is expected.

---

## 6. Session mode

Enter:

```text
Ctrl-g o
```

### Actions

- `d`: detach
- `n`: rename the current session
- `r`: reload `~/.config/tmux/tmux.conf`
- `s`: open the session chooser
- `w`: open the window/session tree chooser
- `x`: open the session chooser, then kill the selected session
- `X`: open the client chooser, then detach the selected client
- `?`: open the custom keymap hints popup
- `c`: show a message about editing and reloading the config
- `o`: return to the normal launcher

`x` does not kill the current session immediately. It opens a chooser first so you can pick the target session. `X` works the same way for clients.

### Differences from zellij

The following features do not exist as direct tmux built-ins:

- `a`: no about plugin
- `p`: no plugin manager UI

Also, zellij's session manager combines rename, disconnect, and kill inside a single floating UI. In tmux, this setup approximates that with separate bindings like `n`, `x`, `X`, and `s`.

---

## Using raw tmux features

This config keeps `Ctrl-b` as the normal tmux prefix, so you can still use the usual tmux flow directly.

Examples:

- `Ctrl-b c`: new window
- `Ctrl-b x`: kill pane
- `Ctrl-b %`: horizontal split
- `Ctrl-b "`: vertical split
## Screen layout notes

### Top status bar

- left: session name
- middle or left area: tab list
- right: current key table plus date and time

### Pane border top label

Each pane shows its pane title in the top border area.

The pane title can change when:

- you rename the pane
- a running program changes the title

## Common real-world scenarios

### Build a simple two-way development layout

```text
Ctrl-g p r
Ctrl-g p d
```

This splits once to the right, then once downward.

### Move quickly between panes

```text
Ctrl-Alt-h/j/k/l
```

Or use pane mode:

```text
Ctrl-g p h/j/k/l
```

### Open multiple tabs and switch between them

```text
Ctrl-g t n
Ctrl-g t n
Ctrl-g t 1
Ctrl-g t 2
```

### Copy logs from the current pane

```text
Ctrl-g s
```

Then:

- move with `k` or `j`
- start selection with `v`
- copy with `y`

### Reload the config after editing

```text
Ctrl-g o r
```

## What still differs from zellij

The following cannot be reproduced exactly because of tmux limitations:

1. floating panes
2. pinned panes
3. plugin UI
4. zellij's richer mode and status UX
5. subtle differences in tab, window, and pane layout philosophy

So this setup gets much closer in feel and workflow, but it does not recreate zellij's full feature model.

## Troubleshooting

### If `Ctrl-Alt-h/j/k/l` does not work

Possible reasons:

- your terminal sends a different sequence for that combo
- your macOS terminal emulator already uses that shortcut

Fallbacks:

- use `Ctrl-g p h/j/k/l`
- check your terminal keybinding settings

### If reload seems not to work

Run this directly:

```bash
tmux source-file ~/.config/tmux/tmux.conf
```

### If you want a completely fresh start

Detach from the existing session, then open a new tmux session.

## One-line summary

For everyday use, this is enough to remember:

- pane actions: `Ctrl-g p ...`
- tab actions: `Ctrl-g t ...`
- resize: `Ctrl-g r ...`
- scroll/copy: `Ctrl-g s`
- move: `Ctrl-g m ...`
- session: `Ctrl-g o ...`
- tmux prefix: `Ctrl-b`
