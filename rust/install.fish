#!/usr/bin/env fish

if not command -qa cargo do
  curl https://sh.rustup.rs -sSf | sh
end

cargo install cargo-update
cargo install stylua

set -Ua fish_user_paths $HOME/.cargo/bin
