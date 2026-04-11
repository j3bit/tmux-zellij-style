# demo

This directory contains a simple automated tmux demo runner.

## Run

```bash
bash ~/.config/tmux/demo/run-demo.sh
```

It starts an isolated tmux server on a separate socket, creates a demo session, and plays through a short scripted sequence showing:

- pane splitting
- pane navigation
- zoom
- tab creation
- commands typed in the new tab
- synchronize-panes
- pane movement
- config reload

It does **not** change your normal tmux server.

## Why this exists

It is useful for:

- quick local preview
- screen recording without manually driving the demo
- later migration to a more polished VHS/asciinema-based workflow

## Notes

- `run-demo.sh` is the live demo runner.
- `render-demo.sh` is the fully automated demo render pipeline.
- Keystroke captions are rendered automatically during the demo itself.

## Render the demo automatically

If `vhs`, `ffmpeg`, and `tmux` are installed, you can regenerate the demo assets automatically:

```bash
bash ~/.config/tmux/demo/render-demo.sh
```

Outputs:

- `demo/output/tmux-zellij-style-demo.gif`
- `demo/output/render-demo.srt`

Only the GIF is intended to stay tracked in git for the top-level README demo.
