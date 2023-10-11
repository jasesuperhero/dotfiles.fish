#!/usr/bin/env fish

set LUA_VERSION "latest"

asdf plugin add lua
asdf install lua $LUA_VERSION
asdf global lua $LUA_VERSION
