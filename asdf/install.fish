#!/usr/bin/env fish

if command -qa asdf
	echo "asdf installed. Everyting is fine"
else
	echo "There is no asdf on the machine"
	exit 1
end

asdf plugin add python
asdf install python 2.7.18
asdf install python 3.10.0
asdf global python 3.10.0 2.7.18

~/.asdf/shims/python -m pip install --upgrade pip
~/.asdf/shims/python -m pip install pynvim
~/.asdf/shims/python2 -m pip install --upgrade pip
~/.asdf/shims/python2 -m pip install pynvim

asdf plugin add ruby
asdf install ruby 3.1.1
asdf global ruby 3.1.1

asdf plugin add lua
asdf install lua 5.4.3
asdf global lua 5.4.3

asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest
