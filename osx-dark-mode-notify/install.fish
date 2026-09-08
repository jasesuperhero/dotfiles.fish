#!/usr/bin/env fish

if test (uname) != Darwin
    exit
end

set LAUNCH_AGENT_ID "com.dkalintsev.dark-notify"
set LAUNCH_AGENT_PLIST "$LAUNCH_AGENT_ID.plist"

# Resolve the dark-notify binary instead of hard-coding /opt/homebrew — Intel
# Homebrew lives at /usr/local, and the binary may be anywhere on PATH.
set -l dark_notify (command -v dark-notify)
if test -z "$dark_notify"; and type -q brew
    set dark_notify (brew --prefix)/bin/dark-notify
end
if test -z "$dark_notify"; or not test -x "$dark_notify"
    echo "dark-notify: binary not found; install with 'brew install cormacrelf/tap/dark-notify'. Skipping." >&2
    exit 0
end

# Logs go into the repo dir (this file lives in $DOTFILES/osx-dark-mode-notify).
set -l log_dir "$DOTFILES/osx-dark-mode-notify"

echo -n "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\"
\"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
    <key>Label</key>
    <string>$LAUNCH_AGENT_ID</string>
    <key>KeepAlive</key>
    <true/>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardErrorPath</key>
    <string>$log_dir/dark-notify-stderr.log</string>
    <key>StandardOutPath</key>
    <string>$log_dir/dark-notify-stdout.log</string>
    <key>ProgramArguments</key>
    <array>
        <string>$dark_notify</string>
        <string>-c</string>
        <string>$DOTFILES/osx-dark-mode-notify/dark_mode_listener.sh</string>
    </array>
</dict>
</plist>" >$DOTFILES/osx-dark-mode-notify/$LAUNCH_AGENT_PLIST

mkdir -p $HOME/Library/LaunchAgents

# Unload old agents (both old and new label) if running
launchctl stop com.dkalintsev.dark-mode-notify 2>/dev/null; or true
launchctl unload $HOME/Library/LaunchAgents/com.dkalintsev.dark-mode-notify.plist 2>/dev/null; or true
launchctl stop $LAUNCH_AGENT_ID 2>/dev/null; or true
launchctl unload $HOME/Library/LaunchAgents/$LAUNCH_AGENT_PLIST 2>/dev/null; or true

rm -f "$HOME/Library/LaunchAgents/com.dkalintsev.dark-mode-notify.plist"
rm -f "$HOME/Library/LaunchAgents/$LAUNCH_AGENT_PLIST"

ln -sf "$DOTFILES/osx-dark-mode-notify/$LAUNCH_AGENT_PLIST" "$HOME/Library/LaunchAgents"

launchctl load -w $HOME/Library/LaunchAgents/$LAUNCH_AGENT_PLIST
