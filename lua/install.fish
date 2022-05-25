#!/usr/bin/env fish

set LUA_VERSION "5.4.3"

asdf plugin add lua
asdf install lua $LUA_VERSION
asdf global lua $LUA_VERSION
