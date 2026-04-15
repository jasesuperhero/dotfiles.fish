#!/usr/bin/env fish

set ZELLIJ_CONFIG_FILE "$HOME/.config/zellij/config.kdl"
set ZELLIJ_LAYOUT_FILE "$HOME/.config/zellij/layouts/default_start.kdl"

switch $C_THEME
    case dark
        sed -i '' -E "s/^theme .*/theme \"catppuccin-mocha\"/" $ZELLIJ_CONFIG_FILE
        sed -i '' \
            -e 's|// Catppuccin.*|// Catppuccin Mocha|' \
            -e 's/color_rosewater "[^"]*"/color_rosewater "#f5e0dc"/' \
            -e 's/color_flamingo  "[^"]*"/color_flamingo  "#f2cdcd"/' \
            -e 's/color_pink      "[^"]*"/color_pink      "#f5c2e7"/' \
            -e 's/color_mauve     "[^"]*"/color_mauve     "#cba6f7"/' \
            -e 's/color_red       "[^"]*"/color_red       "#f38ba8"/' \
            -e 's/color_maroon    "[^"]*"/color_maroon    "#eba0ac"/' \
            -e 's/color_peach     "[^"]*"/color_peach     "#fab387"/' \
            -e 's/color_yellow    "[^"]*"/color_yellow    "#f9e2af"/' \
            -e 's/color_green     "[^"]*"/color_green     "#a6e3a1"/' \
            -e 's/color_teal      "[^"]*"/color_teal      "#94e2d5"/' \
            -e 's/color_sky       "[^"]*"/color_sky       "#89dceb"/' \
            -e 's/color_sapphire  "[^"]*"/color_sapphire  "#74c7ec"/' \
            -e 's/color_blue      "[^"]*"/color_blue      "#89b4fa"/' \
            -e 's/color_lavender  "[^"]*"/color_lavender  "#b4befe"/' \
            -e 's/color_text      "[^"]*"/color_text      "#cdd6f4"/' \
            -e 's/color_subtext1  "[^"]*"/color_subtext1  "#bac2de"/' \
            -e 's/color_subtext0  "[^"]*"/color_subtext0  "#a6adc8"/' \
            -e 's/color_overlay2  "[^"]*"/color_overlay2  "#9399b2"/' \
            -e 's/color_overlay1  "[^"]*"/color_overlay1  "#7f849c"/' \
            -e 's/color_overlay0  "[^"]*"/color_overlay0  "#6c7086"/' \
            -e 's/color_surface2  "[^"]*"/color_surface2  "#585b70"/' \
            -e 's/color_surface1  "[^"]*"/color_surface1  "#45475a"/' \
            -e 's/color_surface0  "[^"]*"/color_surface0  "#313244"/' \
            -e 's/color_base      "[^"]*"/color_base      "#1e1e2e"/' \
            -e 's/color_mantle    "[^"]*"/color_mantle    "#181825"/' \
            -e 's/color_crust     "[^"]*"/color_crust     "#11111b"/' \
            $ZELLIJ_LAYOUT_FILE
    case light
        sed -i '' -E "s/^theme .*/theme \"catppuccin-latte\"/" $ZELLIJ_CONFIG_FILE
        sed -i '' \
            -e 's|// Catppuccin.*|// Catppuccin Latte|' \
            -e 's/color_rosewater "[^"]*"/color_rosewater "#dc8a78"/' \
            -e 's/color_flamingo  "[^"]*"/color_flamingo  "#dd7878"/' \
            -e 's/color_pink      "[^"]*"/color_pink      "#ea76cb"/' \
            -e 's/color_mauve     "[^"]*"/color_mauve     "#8839ef"/' \
            -e 's/color_red       "[^"]*"/color_red       "#d20f39"/' \
            -e 's/color_maroon    "[^"]*"/color_maroon    "#e64553"/' \
            -e 's/color_peach     "[^"]*"/color_peach     "#fe640b"/' \
            -e 's/color_yellow    "[^"]*"/color_yellow    "#df8e1d"/' \
            -e 's/color_green     "[^"]*"/color_green     "#40a02b"/' \
            -e 's/color_teal      "[^"]*"/color_teal      "#179299"/' \
            -e 's/color_sky       "[^"]*"/color_sky       "#04a5e5"/' \
            -e 's/color_sapphire  "[^"]*"/color_sapphire  "#209fb5"/' \
            -e 's/color_blue      "[^"]*"/color_blue      "#1e66f5"/' \
            -e 's/color_lavender  "[^"]*"/color_lavender  "#7287fd"/' \
            -e 's/color_text      "[^"]*"/color_text      "#4c4f69"/' \
            -e 's/color_subtext1  "[^"]*"/color_subtext1  "#5c5f77"/' \
            -e 's/color_subtext0  "[^"]*"/color_subtext0  "#6c6f85"/' \
            -e 's/color_overlay2  "[^"]*"/color_overlay2  "#7c7f93"/' \
            -e 's/color_overlay1  "[^"]*"/color_overlay1  "#8c8fa1"/' \
            -e 's/color_overlay0  "[^"]*"/color_overlay0  "#9ca0b0"/' \
            -e 's/color_surface2  "[^"]*"/color_surface2  "#acb0be"/' \
            -e 's/color_surface1  "[^"]*"/color_surface1  "#bcc0cc"/' \
            -e 's/color_surface0  "[^"]*"/color_surface0  "#ccd0da"/' \
            -e 's/color_base      "[^"]*"/color_base      "#eff1f5"/' \
            -e 's/color_mantle    "[^"]*"/color_mantle    "#e6e9ef"/' \
            -e 's/color_crust     "[^"]*"/color_crust     "#dce0e8"/' \
            $ZELLIJ_LAYOUT_FILE
    case "*"
        exit 1
end
