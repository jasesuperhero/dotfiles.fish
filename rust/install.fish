#!/usr/bin/env fish

set RUST_VERSION "1.67.1"

asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git
asdf install rust $RUST_VERSION
asdf global rust $RUST_VERSION

cargo install cargo-update
cargo install stylua

set -Ua fish_user_paths $HOME/.cargo/bin
