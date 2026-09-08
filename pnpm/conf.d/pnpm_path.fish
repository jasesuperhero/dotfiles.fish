if test (uname) = Darwin
    set -gx PNPM_HOME "$HOME/Library/pnpm"
else
    set -gx PNPM_HOME "$HOME/.local/share/pnpm"
end

# pnpm installs global package binaries into $PNPM_HOME/bin. Append it (not
# prepend) so a mise-managed `pnpm` keeps priority over anything pnpm drops here.
fish_add_path -ga $PNPM_HOME/bin
