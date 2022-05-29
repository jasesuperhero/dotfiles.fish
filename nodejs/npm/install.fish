#!/usr/bin/env fish

for package in (cat "$DOTFILES/nodejs/npm/npm_packages.txt")
  echo "[npm] Installing package $package..."
  npm install --global "$package"
end
