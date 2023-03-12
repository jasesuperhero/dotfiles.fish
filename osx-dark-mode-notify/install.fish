#!/usr/bin/env fish

cp -rf $DOTFILES/osx-dark-mode-notify/bins/dark-mode-notify /usr/local/bin

set LAUCNH_AGENT_ID "com.dkalintsev.dark-mode-notify"
set LAUNCH_AGENT_PLIST "$LAUCNH_AGENT_ID.plist"

mkdir -p $HOME/Library/LaunchAgents
rm -rf "$HOME/Library/LaunchAgents/$LAUNCH_AGENT_PLIST"

ln -sf "$DOTFILES/osx-dark-mode-notify/$LAUNCH_AGENT_PLIST" "$HOME/Library/LaunchAgents"

launchctl stop $LAUCNH_AGENT_ID || true
launchctl unload $HOME/Library/LaunchAgents/$LAUNCH_AGENT_PLIST || true

launchctl load -w $HOME/Library/LaunchAgents/$LAUNCH_AGENT_PLIST
