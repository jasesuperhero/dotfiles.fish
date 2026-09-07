#!/usr/bin/env fish
# macOS imperative exceptions that aren't `defaults` keys.
#
# Migrated here from macos/set-defaults.sh. Deliberately DROPPED (see README):
#   - LSQuarantine=false          (security-reducing: disables Gatekeeper prompt)
#   - dashboard mcx-disabled      (Dashboard removed since Catalina — no-op)
#   - pmset hibernatemode 0 / sleepimage rm+chflags  (legacy Intel-SSD tweak)
#   - tmutil disablelocal         (unsupported on modern APFS)
#   - pmset sms 0                 (sudden-motion-sensor — irrelevant on SSD/AS)
#   - standbydelay / BezelServices kDimTime / AppleAquaColorVariant / graphite
#   - Transmission/Mail app blocks (app-specific; may not be installed)
# AppleInterfaceStyle is intentionally NOT forced — dark-notify observes the
# system appearance and drives the theme; forcing Dark would fight it.

test (uname) = Darwin; or exit 0

# Filesystem visibility (no equivalent `defaults` key).
chflags nohidden ~/Library 2>/dev/null; or true
sudo chflags nohidden /Volumes 2>/dev/null; or true

# dark-notify LaunchAgent: system appearance -> ~/.theme -> C_THEME.
fish "$DOTFILES/osx-dark-mode-notify/install.fish"

# Restart affected UI apps so [bootstrap.macos.defaults] changes take effect.
# Only if running, to avoid spurious launches.
for app in Dock Finder SystemUIServer
    pgrep -x $app >/dev/null; and killall $app 2>/dev/null; or true
end
