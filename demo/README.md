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
- `render-demo.sh` is the fully automated MP4 pipeline.
- Keystroke captions are rendered automatically during the demo itself.
- If the local `ffmpeg` build supports subtitle filters, `render-demo.sh` can also burn the generated `.srt` file into the final MP4.

## Render MP4 automatically

If `vhs`, `ffmpeg`, and `tmux` are installed, you can render an MP4 with burned-in keystroke captions:

```bash
bash ~/.config/tmux/demo/render-demo.sh
```

Outputs:

- `demo/output/tmux-zellij-style-demo.raw.mp4`
- `demo/output/tmux-zellij-style-demo.mp4`
- `demo/output/tmux-zellij-style-demo.gif`
- `demo/output/render-demo.srt`

Only the GIF is intended to stay tracked in git for the top-level README demo. The MP4 files are local render artifacts.
