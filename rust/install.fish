#!/usr/bin/env fish

set RUST_VERSION latest

mise install --yes rust@$RUST_VERSION
mise use --global rust@$RUST_VERSION

cargo install --locked cargo-update &
cargo install --locked stylua &
cargo install --locked cargo-nextest &
wait

set -Ua fish_user_paths $HOME/.cargo/bin
