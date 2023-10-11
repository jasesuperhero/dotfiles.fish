#!/usr/bin/env fish

set PYTHON_VERSION "latest"

asdf plugin add python
asdf install python $PYTHON_VERSION
asdf global python $PYTHON_VERSION

~/.asdf/shims/python -m pip install --upgrade pip
~/.asdf/shims/python -m pip install pynvim
~/.asdf/shims/python2 -m pip install --upgrade pip
~/.asdf/shims/python2 -m pip install pynvim

fish $DOTFILES/python/pip/install.fish
