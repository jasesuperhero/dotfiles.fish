#!/usr/bin/env fish

set LUA_VERSION latest

mise install --yes lua@$LUA_VERSION
mise use --global lua@$LUA_VERSION
