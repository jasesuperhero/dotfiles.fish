#!/usr/bin/env fish
# Build zellij plugins that have no prebuilt wasm release, into
# ~/.config/zellij/plugins/. Idempotent: skips a plugin whose wasm already exists.
# Cross-platform (needs the mise-managed rust toolchain + git).

set -l plugin_dir ~/.config/zellij/plugins
mkdir -p $plugin_dir

# --- vimkim/zellij-new-tab-next-to-current (no GitHub release; build from source) ---
set -l wasm "$plugin_dir/zellij-new-tab-next-to-current.wasm"
if test -f "$wasm"
    echo "zellij-plugins: new-tab-next-to-current.wasm already present; skipping"
else if not command -q cargo
    echo "zellij-plugins: cargo not found (is the mise rust tool installed?); skipping" >&2
else
    rustup target add wasm32-wasip1 2>/dev/null; or true
    set -l tmp (mktemp -d)
    if git clone --depth 1 https://github.com/vimkim/zellij-new-tab-next-to-current.git "$tmp/src" 2>/dev/null
        and cargo build --release --manifest-path "$tmp/src/Cargo.toml" --target wasm32-wasip1
        and test -f "$tmp/src/target/wasm32-wasip1/release/zellij-new-tab-next-to-current.wasm"
        cp "$tmp/src/target/wasm32-wasip1/release/zellij-new-tab-next-to-current.wasm" "$wasm"
        echo "zellij-plugins: built zellij-new-tab-next-to-current.wasm"
    else
        echo "zellij-plugins: build failed (offline / missing toolchain?); skipping" >&2
    end
    rm -rf "$tmp"
end
