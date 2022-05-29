#!/usr/bin/env fish

for plugin in (cat "$DOTFILES/fisher/plugins")
  echo "[fisher] Installing plugin $plugin..."
  fisher install "$plugin"
end
