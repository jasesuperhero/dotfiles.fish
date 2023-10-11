#!/usr/bin/env fish

set RUST_VERSION "latest"

asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git
asdf install rust $RUST_VERSION
asdf global rust $RUST_VERSION

cargo install --locked cargo-update
cargo install --locked stylua

set -Ua fish_user_paths $HOME/.cargo/bin
