#!/usr/bin/env bash
set -euo pipefail

SOCKET="${TMUX_ZELLIJ_DEMO_SOCKET:-tmux-zellij-demo}"
SESSION="${TMUX_ZELLIJ_DEMO_SESSION:-demo}"
CONFIG="${TMUX_ZELLIJ_DEMO_CONFIG:-$HOME/.config/tmux/tmux.conf}"
WIDTH="${TMUX_ZELLIJ_DEMO_WIDTH:-120}"
HEIGHT="${TMUX_ZELLIJ_DEMO_HEIGHT:-32}"
DEMO_SHELL="${TMUX_ZELLIJ_DEMO_SHELL:-bash --noprofile --norc}"
NO_ATTACH="${TMUX_ZELLIJ_DEMO_NO_ATTACH:-0}"
MESSAGE_MS="${TMUX_ZELLIJ_DEMO_MESSAGE_MS:-5200}"

tmux_cmd() {
  tmux -L "$SOCKET" -f "$CONFIG" "$@"
}

cleanup() {
  tmux -L "$SOCKET" kill-server >/dev/null 2>&1 || true
}

say() {
  local text="$1"
  tmux_cmd display-message -d "$MESSAGE_MS" "Keys: $text"
}

type_in_pane() {
  local target="$1"
  shift
  tmux_cmd send-keys -t "$target" "$@" C-m
}

pause() {
  sleep "${1:-2.4}"
}

trap cleanup EXIT INT TERM

cleanup
tmux_cmd new-session -d -s "$SESSION" -x "$WIDTH" -y "$HEIGHT" "$DEMO_SHELL"
tmux_cmd rename-window -t "$SESSION":1 "editor"
tmux_cmd select-pane -t "$SESSION":1.1 -T "main"

type_in_pane "$SESSION":1.1 "clear"
type_in_pane "$SESSION":1.1 "printf 'tmux-zellij-style demo\n\n'; printf 'Ctrl-g launcher + modal flow on top of tmux.\n\n'"
type_in_pane "$SESSION":1.1 "for i in \$(seq 1 60); do printf 'log line %02d  pane=main  status=ok\n' \"\$i\"; done"

(
  pause 2.8
  say "Ctrl-g p r  -> split right"
  tmux_cmd split-window -h -t "$SESSION":1 -c "#{pane_current_path}" "$DEMO_SHELL"
  tmux_cmd select-pane -t "$SESSION":1.2 -T "shell"
  type_in_pane "$SESSION":1.2 "clear"
  type_in_pane "$SESSION":1.2 "printf 'right pane\n\n'; printf 'demo command output only\n'; printf 'no host, no path, no personal shell prompt\n'"

  pause
  say "Ctrl-g p d  -> split down"
  tmux_cmd select-pane -t "$SESSION":1.1
  tmux_cmd split-window -v -t "$SESSION":1.1 -c "#{pane_current_path}" "$DEMO_SHELL"
  tmux_cmd select-pane -t "$SESSION":1.3 -T "logs"
  type_in_pane "$SESSION":1.3 "clear"
  type_in_pane "$SESSION":1.3 "printf 'bottom pane\n\n'; for i in \$(seq 1 12); do printf 'event %02d processed\n' \"\$i\"; done"

  pause
  say "Ctrl-g p h/j/k/l  -> move between panes"
  tmux_cmd select-pane -t "$SESSION":1.1
  pause 1.4
  tmux_cmd select-pane -t "$SESSION":1.2
  pause 1.4
  tmux_cmd select-pane -t "$SESSION":1.3
  pause 1.4
  tmux_cmd select-pane -t "$SESSION":1.1

  pause
  say "Ctrl-g p f  -> zoom current pane"
  tmux_cmd resize-pane -Z -t "$SESSION":1.1
  pause 2.0
  tmux_cmd resize-pane -Z -t "$SESSION":1.1

  pause
  say "Ctrl-g t n  -> new tab"
  tmux_cmd new-window -t "$SESSION" -n "notes" -c "#{pane_current_path}" "$DEMO_SHELL"
  type_in_pane "$SESSION":2.1 "clear"
  type_in_pane "$SESSION":2.1 "printf 'new tab / window\n\n'; printf '- tmux maps zellij-style tabs to tmux windows\n'; printf '- this pane also uses the demo shell\n'; printf '- no machine-specific path output here\n\n'"
  pause 1.2
  say "new tab command  ->  run something here too"
  type_in_pane "$SESSION":2.1 "for item in inbox draft sent archive; do printf 'note bucket: %s\n' \"\$item\"; done"

  pause
  say "Ctrl-g t Tab  -> back to previous tab"
  tmux_cmd last-window -t "$SESSION"

  pause
  say "Ctrl-g t s  -> synchronize panes"
  tmux_cmd set-window-option -t "$SESSION":1 synchronize-panes on
  tmux_cmd select-pane -t "$SESSION":1.1
  type_in_pane "$SESSION":1.1 "printf '[sync] one command reached every pane\n'"
  pause 2.0
  tmux_cmd set-window-option -t "$SESSION":1 synchronize-panes off

  pause
  say "Ctrl-g m h/j/k/l  -> move panes"
  tmux_cmd select-pane -t "$SESSION":1.3
  tmux_cmd swap-pane -d -s "$SESSION":1.3 -t "$SESSION":1.2
  pause 2.0
  tmux_cmd swap-pane -d -s "$SESSION":1.2 -t "$SESSION":1.3
  tmux_cmd select-pane -t "$SESSION":1.1
  type_in_pane "$SESSION":1.1 "printf 'main pane still active after move demo\n'"
  pause 1.2
  tmux_cmd select-pane -t "$SESSION":1.2
  type_in_pane "$SESSION":1.2 "printf 'right pane got its own follow-up command\n'"
  pause 1.2
  tmux_cmd select-pane -t "$SESSION":1.3
  type_in_pane "$SESSION":1.3 "printf 'bottom pane also received separate input\n'"
  pause 1.2
  tmux_cmd select-pane -t "$SESSION":1.1

  pause
  say "Ctrl-g o r  -> reload config"
  tmux_cmd source-file "$CONFIG"
  pause 2.0

  say "Demo complete. Detach with Ctrl-g q or exit this terminal."
) &

driver_pid=$!

if [[ "$NO_ATTACH" == "1" ]]; then
  wait "$driver_pid"
  exit 0
fi

exec tmux -L "$SOCKET" attach -t "$SESSION"
