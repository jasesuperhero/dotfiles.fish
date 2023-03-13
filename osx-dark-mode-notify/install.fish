#!/usr/bin/env fish

cp -rf $DOTFILES/osx-dark-mode-notify/bins/dark-mode-notify /usr/local/bin

echo -n "<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
"http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.dkalintsev.dark-mode-notify</string>
    <key>KeepAlive</key>
    <true/>
    <key>StandardErrorPath</key>
    <string>$HOME/osx-dark-mode-notify/dark-mode-notify-stderr.log</string>
    <key>StandardOutPath</key>
    <string>$HOME/osx-dark-mode-notify/dark-mode-notify-stdout.log</string>
    <key>ProgramArguments</key>
    <array>
       <string>/usr/local/bin/dark-mode-notify</string>
       <string>$(which fish)</string>
       <string>--no-config</string>
       <string>-c</string>
       <string>$HOME/.dotfiles/osx-dark-mode-notify/dark_mode_listener.fish</string>
    </array>
</dict>
</plist>" > $DOTFILES/osx-dark-mode-notify/com.dkalintsev.dark-mode-notify.plist

echo -n "#!$(which fish)

switch \$DARKMODE
  case 1
    update_theme dark
  case 0
    update_theme light
end" > $DOTFILES/osx-dark-mode-notify/dark_mode_listener.fish
chmod +x $DOTFILES/osx-dark-mode-notify/dark_mode_listener.fish

set LAUCNH_AGENT_ID "com.dkalintsev.dark-mode-notify"
set LAUNCH_AGENT_PLIST "$LAUCNH_AGENT_ID.plist"

mkdir -p $HOME/Library/LaunchAgents
rm -rf "$HOME/Library/LaunchAgents/$LAUNCH_AGENT_PLIST"

ln -sf "$DOTFILES/osx-dark-mode-notify/$LAUNCH_AGENT_PLIST" "$HOME/Library/LaunchAgents"

launchctl stop $LAUCNH_AGENT_ID || true
launchctl unload $HOME/Library/LaunchAgents/$LAUNCH_AGENT_PLIST || true

launchctl load -w $HOME/Library/LaunchAgents/$LAUNCH_AGENT_PLIST
