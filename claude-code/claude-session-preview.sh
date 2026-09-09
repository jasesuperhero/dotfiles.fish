#!/bin/sh
# Preview for the `claude-sessions` fzf picker.
# $1 = path to a state file (key=value lines written by claude-notify.sh).
# Prints the session's state, then a best-effort tail of its Claude transcript.
set -eu

f="${1:-}"
[ -n "$f" ] && [ -f "$f" ] || exit 0

echo "── session ──"
# Show the human-readable fields; hide the raw transcript/session_id paths.
grep -vE '^(transcript|session_id)=' "$f" 2>/dev/null || true

# Transcript tail (best-effort; the JSONL schema can vary, so fall back to raw).
t="$(sed -n 's/^transcript=//p' "$f" 2>/dev/null || true)"
[ -n "$t" ] && [ -f "$t" ] || exit 0

echo
echo "── transcript ──"
if command -v jq >/dev/null 2>&1; then
    out="$(tail -n 80 "$t" 2>/dev/null | jq -r '
        (.message.content? // .content? // empty) as $c
        | ($c | if type == "array" then (map(.text? // empty) | join(" ")) else (. | tostring) end)
        | select(. != null and . != "")
    ' 2>/dev/null | tail -n 30 || true)"
    if [ -n "$out" ]; then
        printf '%s\n' "$out"
    else
        tail -n 15 "$t" 2>/dev/null || true
    fi
else
    tail -n 15 "$t" 2>/dev/null || true
fi
