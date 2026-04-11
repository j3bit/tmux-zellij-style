#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEMO_DIR="$ROOT_DIR/demo"
OUTPUT_DIR="$DEMO_DIR/output"
RAW_MP4="$OUTPUT_DIR/tmux-zellij-style-demo.raw.mp4"
FINAL_MP4="$OUTPUT_DIR/tmux-zellij-style-demo.mp4"
TAPE_FILE="$OUTPUT_DIR/render-demo.tape"
SRT_FILE="$OUTPUT_DIR/render-demo.srt"
SOCKET="tmux-zellij-vhs"

require() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing dependency: $1" >&2
    exit 1
  }
}

require vhs
require tmux

mkdir -p "$OUTPUT_DIR"
chmod +x "$DEMO_DIR/run-demo.sh"

cat >"$TAPE_FILE" <<EOF
Output "$RAW_MP4"

Require bash
Require tmux

Set Shell "bash"
Set FontFamily "D2CodingLigatureNFM"
Set FontSize 24
Set Width 1500
Set Height 980
Set Theme "nord"
Set Padding 20
Set WindowBar Colorful
Set BorderRadius 10
Set Framerate 30
Set TypingSpeed 0ms

Hide
Type "TMUX_ZELLIJ_DEMO_SOCKET=$SOCKET ./demo/run-demo.sh"
Enter
Show

Sleep 48s
EOF

python3 - <<'PY' >"$SRT_FILE"
from datetime import timedelta

def fmt(seconds: float) -> str:
    ms = int(round(seconds * 1000))
    td = timedelta(milliseconds=ms)
    total_seconds = int(td.total_seconds())
    millis = ms % 1000
    hours = total_seconds // 3600
    minutes = (total_seconds % 3600) // 60
    seconds = total_seconds % 60
    return f"{hours:02}:{minutes:02}:{seconds:02},{millis:03}"

scenes = [
    (2.80, 5.20, "Ctrl-g p r  →  split right"),
    (5.20, 7.60, "Ctrl-g p d  →  split down"),
    (7.60, 11.80, "Ctrl-g p h/j/k/l  →  move between panes"),
    (11.80, 16.20, "Ctrl-g p f  →  zoom current pane"),
    (16.20, 18.60, "Ctrl-g t n  →  new tab"),
    (18.60, 21.60, "new tab command  →  run something here too"),
    (21.60, 24.00, "Ctrl-g t Tab  →  back to previous tab"),
    (24.00, 27.80, "Ctrl-g t s  →  synchronize panes"),
    (27.80, 35.20, "Ctrl-g m h/j/k/l  →  move panes"),
    (35.20, 39.00, "Ctrl-g o r  →  reload config"),
]

for index, (start, end, text) in enumerate(scenes, start=1):
    print(index)
    print(f"{fmt(start)} --> {fmt(end)}")
    print(text)
    print()
PY

echo "Rendering MP4 with VHS..."
vhs "$TAPE_FILE"

can_burn_with_ffmpeg=0
if command -v ffmpeg >/dev/null 2>&1; then
  if ffmpeg -hide_banner -filters 2>/dev/null | grep -q ' subtitles '; then
    can_burn_with_ffmpeg=1
  fi
fi

if [[ "$can_burn_with_ffmpeg" == "1" ]]; then
  echo "Burning external subtitles into final MP4..."
  (
    cd "$OUTPUT_DIR"
    ffmpeg -y \
      -i "$(basename "$RAW_MP4")" \
      -vf "subtitles=filename=$(basename "$SRT_FILE"):force_style='FontName=Helvetica,FontSize=18,PrimaryColour=&H00FFFFFF,OutlineColour=&H64000000,BackColour=&H96000000,BorderStyle=3,Outline=1,Shadow=0,Alignment=2,MarginV=26'" \
      -an \
      -c:v libx264 \
      -pix_fmt yuv420p \
      -preset medium \
      -crf 20 \
      "$(basename "$FINAL_MP4")"
  )
else
  echo "ffmpeg subtitle filter unavailable; using tmux-rendered on-screen keystroke captions."
  cp "$RAW_MP4" "$FINAL_MP4"
fi

echo
echo "Done."
echo "Raw MP4:   $RAW_MP4"
echo "Final MP4: $FINAL_MP4"
echo "Subtitles: $SRT_FILE"
