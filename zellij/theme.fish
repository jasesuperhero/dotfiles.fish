#!/usr/bin/env fish

set ZELLIJ_CONFIG_FILE "$HOME/.config/zellij/config.kdl"
set ZELLIJ_LAYOUT_FILE "$HOME/.config/zellij/layouts/default_start.kdl"
set SCRIPTS_DIR        "$HOME/.config/zellij/scripts"
set TEMPLATE           "$DOTFILES/zellij/config/layouts/default_start.kdl"

switch $C_THEME
    case dark
        set zellij_theme "catppuccin-mocha"
        set color_file "$DOTFILES/zellij/themes/zjstatus_mocha.kdl"
    case light
        set zellij_theme "catppuccin-latte"
        set color_file "$DOTFILES/zellij/themes/zjstatus_latte.kdl"
    case "*"
        exit 1
end

sed -i '' -E "s/^theme .*/theme \"$zellij_theme\"/" $ZELLIJ_CONFIG_FILE

# Assemble layout: replace ZJSTATUS_COLORS marker with theme colour definitions
awk -v cf="$color_file" '
    /ZJSTATUS_COLORS/ { while ((getline line < cf) > 0) print line; next }
    { print }
' $TEMPLATE > $ZELLIJ_LAYOUT_FILE

# Substitute the scripts path placeholder
sed -i '' "s|ZJSTATUS_SCRIPTS_DIR|$SCRIPTS_DIR|g" $ZELLIJ_LAYOUT_FILE

# Reload zjstatus in all running (non-exited) zellij sessions
if command -q zellij
    for session in (zellij list-sessions --no-formatting 2>/dev/null | grep -v EXITED | awk '{print $1}')
        zellij --session $session pipe -p zjstatus -- "reload::" &>/dev/null
    end
end
