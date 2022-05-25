#!/usr/bin/env fish

asdf plugin add python
asdf install python 2.7.18
asdf install python 3.10.0
asdf global python 3.10.0 2.7.18

~/.asdf/shims/python -m pip install --upgrade pip
~/.asdf/shims/python -m pip install pynvim
~/.asdf/shims/python2 -m pip install --upgrade pip
~/.asdf/shims/python2 -m pip install pynvim

fish $DOTFILES/python/pip/install.fish
