#!/usr/bin/env fish

if command -q fd
    # `f` rather than shadowing `find`: fd and find take incompatible syntax, so
    # aliasing `find`->`fd` turns muscle-memory `find . -name x` into a wrong/erroring
    # `fd . -name x`. Keep real `find` intact; use `f` for fd.
    abbr -a f fd
end
