#!/bin/sh
set -eu

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zjstatus"
CACHE_FILE="$CACHE_DIR/cpu_used"
TTL=2

mkdir -p "$CACHE_DIR"

now() { date +%s; }

print_cached_if_fresh() {
    [ -f "$CACHE_FILE" ] || return 1

    ts=$(sed -n '1p' "$CACHE_FILE" 2>/dev/null || true)
    val=$(sed -n '2p' "$CACHE_FILE" 2>/dev/null || true)

    [ -n "${ts:-}" ] && [ -n "${val:-}" ] || return 1

    age=$(($(now) - ts))
    [ "$age" -lt "$TTL" ] || return 1

    printf '%s\n' "$val"
    return 0
}

save_cache() {
    {
        printf '%s\n' "$(now)"
        printf '%s\n' "$1"
    } >"$CACHE_FILE"
}

get_loadavg_linux() {
    awk '{print $1}' /proc/loadavg
}

get_loadavg_macos() {
    # vm.loadavg returns "{ 1.23 0.45 0.67 }" — $2 is the 1-minute value
    sysctl -n vm.loadavg | awk '{print $2}'
}

print_cached_if_fresh && exit 0

case "$(uname -s)" in
Linux) result=$(get_loadavg_linux) ;;
Darwin) result=$(get_loadavg_macos) ;;
*) result="N/A" ;;
esac

save_cache "$result"
printf '%s\n' "$result"
