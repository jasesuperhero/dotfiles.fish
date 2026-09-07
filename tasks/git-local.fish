#!/usr/bin/env fish
# Wire ~/.gitconfig to the tracked config and preserve the user's identity.
# Identity lives ONLY in ~/.gitconfig (never hard-coded in the tracked repo);
# it is prompted for only when missing, never overwritten.

set -l gitconfig "$HOME/.gitconfig"
test -f "$gitconfig"; or touch "$gitconfig"

# Ensure include.path -> tracked gitconfig (idempotent).
set -l want "$DOTFILES/git/gitconfig"
git config --file "$gitconfig" --get-all include.path 2>/dev/null | grep -Fxq "$want"
or git config --file "$gitconfig" --add include.path "$want"

# Prompt for identity ONLY if missing.
if test -z (git config --global user.name)
    read -P "Git author name: " name
    and test -n "$name"
    and git config --global user.name "$name"
end
if test -z (git config --global user.email)
    read -P "Git author email: " email
    and test -n "$email"
    and git config --global user.email "$email"
end

# macOS: keychain credential helper (was git/install.fish).
if test (uname) = Darwin
    test (git config --global credential.helper) = osxkeychain
    or git config --global credential.helper osxkeychain
end

# gh: prefer ssh for git ops + gh-dash extension (was gh/install.fish, gh-dash/install.fish).
if command -q gh
    set -l proto (gh config get git_protocol 2>/dev/null)
    test "$proto" = ssh
    or gh config set git_protocol ssh
    gh extension list 2>/dev/null | grep -q dlvhdr/gh-dash
    or gh extension install dlvhdr/gh-dash 2>/dev/null
    or true
end

# Install this repo's git pre-commit hooks (was git-hooks/install.fish).
if command -q prek; and test -f "$DOTFILES/.pre-commit-config.yaml"
    pushd "$DOTFILES"
    prek install 2>/dev/null; or true
    popd
end
