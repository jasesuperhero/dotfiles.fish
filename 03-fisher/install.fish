#!/usr/bin/env fish

for plugin in (cat "$DOTFILES/03-fisher/plugins")
  echo "[fisher] Installing plugin $plugin..."
  fisher install "$plugin"
end
