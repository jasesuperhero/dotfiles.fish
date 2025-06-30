#!/usr/bin/env fish

set RUST_VERSION latest

mise install --yes rust@$RUST_VERSION
mise use --global rust@$RUST_VERSION

cargo install cargo-update
cargo install stylua
cargo install cargo-nextest

set -Ua fish_user_paths $HOME/.cargo/bin
