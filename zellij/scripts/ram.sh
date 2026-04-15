#!/bin/sh
set -eu

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zjstatus"
CACHE_FILE="$CACHE_DIR/ram_used"
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

format_gib() {
    awk -v bytes="$1" '
        BEGIN {
            gib = bytes / (1024 * 1024 * 1024)
            if (gib >= 10) printf "%.0fGiB\n", gib
            else printf "%.1fGiB\n", gib
        }
    '
}

# Outputs: <percent> <total_bytes>
get_ram_linux() {
    awk '
        /^MemTotal:/     { total = $2 }
        /^MemAvailable:/ { avail = $2 }
        END {
            used = total - avail
            perc = int(used * 100 / total + 0.5)
            print perc, total * 1024
        }
    ' /proc/meminfo
}

# Outputs: <percent> <total_bytes>
get_ram_macos() {
    page_size=$(sysctl -n hw.pagesize)
    total=$(sysctl -n hw.memsize)

    vm_stat | awk -v page_size="$page_size" -v total="$total" '
        /Pages free:/        { gsub("\\.","",$3); free=$3 }
        /Pages speculative:/ { gsub("\\.","",$3); spec=$3 }
        END {
            available = (free + spec) * page_size
            used = total - available
            perc = int(used * 100 / total + 0.5)
            print perc, total
        }
    '
}

print_cached_if_fresh && exit 0

case "$(uname -s)" in
Linux)
    set -- $(get_ram_linux)
    perc=$1
    total_bytes=$2
    ;;
Darwin)
    set -- $(get_ram_macos)
    perc=$1
    total_bytes=$2
    ;;
*)
    printf 'N/A\n'
    exit 0
    ;;
esac

total_fmt=$(format_gib "$total_bytes")
result="${perc}% ${total_fmt}"
save_cache "$result"
printf '%s\n' "$result"
