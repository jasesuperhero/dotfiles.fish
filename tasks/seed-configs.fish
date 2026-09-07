#!/usr/bin/env fish
# Seed the configs that mise [dotfiles] can't own because their theme scripts
# rewrite the files in place (atuin/zellij) or edit a copied file (starship).
# Also rebuilds the bat cache and applies the current theme. Fully idempotent.

# Ensure a theme is selected (dark default) before seeding theme-aware configs.
if not set -q C_THEME
    if test -f ~/.theme
        set -gx C_THEME (string trim <~/.theme)
    else
        set -gx C_THEME dark
        echo dark >~/.theme
    end
end

# --- atuin: real dir so theme.fish can `sed` the config in place -------------
test -L ~/.config/atuin; and rm ~/.config/atuin
mkdir -p ~/.config/atuin
cp -f "$DOTFILES/atuin/config/config.toml" ~/.config/atuin/config.toml
test -e ~/.config/atuin/themes; or ln -sf "$DOTFILES/atuin/config/themes" ~/.config/atuin/themes

# --- zellij: real dir (config + themes symlink + real layouts + scripts) -----
test -L ~/.config/zellij; and rm ~/.config/zellij
mkdir -p ~/.config/zellij ~/.config/zellij/scripts
cp -f "$DOTFILES/zellij/config/config.kdl" ~/.config/zellij/config.kdl
test -e ~/.config/zellij/themes; or ln -sf "$DOTFILES/zellij/config/themes" ~/.config/zellij/themes
test -L ~/.config/zellij/layouts; and rm ~/.config/zellij/layouts
mkdir -p ~/.config/zellij/layouts
cp -f "$DOTFILES"/zellij/scripts/*.sh ~/.config/zellij/scripts/ 2>/dev/null; or true
chmod +x ~/.config/zellij/scripts/*.sh 2>/dev/null; or true

# --- starship: real file so theme.fish can `sed` the palette -----------------
cp -f "$DOTFILES/starship/starship.toml" ~/.config/starship.toml

# --- bat: rebuild syntax/theme cache (was bat/install.fish) ------------------
command -q bat; and bat cache --build 2>/dev/null; or true

# --- atuin: import existing shell history on first setup only -----------------
if command -q atuin; and not test -f ~/.local/share/atuin/history.db
    atuin import auto 2>/dev/null; or true
end

# --- apply the current theme across all tools (also establishes saved aliases) -
set -l ut "$DOTFILES/02-fish/functions/update_theme.fish"
if test -f "$ut"
    fish -c "source $ut; update_theme $C_THEME" 2>/dev/null; or true
end
