#!/usr/bin/env fish

if not command -qs tmux
	exit
end

rm -rf ~/.config/tmux/plugins
test -d ~/.config/tmux/plugins/tpm || git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
