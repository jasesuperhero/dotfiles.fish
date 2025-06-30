#!/usr/bin/env fish

set PYTHON_VERSION latest

mise install --yes python@$PYTHON_VERSION
mise use --global python@$PYTHON_VERSION

pip install --upgrade pip
pip install pynvim

fish $DOTFILES/python/pip/install.fish
