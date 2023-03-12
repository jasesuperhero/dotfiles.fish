#!/usr/bin/env fish

# bootstrap installs things.

set DOTFILES_ROOT (pwd -P)

function info
    echo [(set_color --bold) ' .. ' (set_color normal)] $argv
end

function user
    echo [(set_color --bold) ' ?? ' (set_color normal)] $argv
end

function success
    echo [(set_color --bold green) ' OK ' (set_color normal)] $argv
end

function abort
    echo [(set_color --bold yellow) ABRT (set_color normal)] $argv
    exit 1
end

function on_exit -p %self
    if not contains $argv[3] 0
        echo [(set_color --bold red) FAIL (set_color normal)] "Couldn't setup dotfiles, please open an issue at https://github.com/caarlos0/dotfiles"
    end
end

function setup_gitconfig
    if not test -f $HOME/.gitconfig.local
        touch $HOME/.gitconfig.local
    end

    set managed (git config --file $HOME/.gitconfig.local --get dotfiles.managed)
    # if there is no user.email, we'll assume it's a new machine/setup and ask it
    if test -z (git config --file $HOME/.gitconfig.local --get user.email)
        user 'What is your github author name?'
        read user_name
        user 'What is your github author email?'
        read user_email

        test -n $user_name
        or echo "please inform the git author name"
        test -n $user_email
        or abort "please inform the git author email"

        git config --file $HOME/.gitconfig.local user.name $user_name
        and git config --file $HOME/.gitconfig.local user.email $user_email
        or abort 'failed to setup git user name and email'
    else if test '$managed' = true
        # if user.email exists, let's check for dotfiles.managed config. If it is
        # not true, we'll backup the gitconfig file and set previous user.email and
        # user.name in the new one
        set user_name (git config --file $HOME/.gitconfig.local --get user.name)
        and set user_email (git config --file $HOME/.gitconfig.local --get user.email)
        and git config --file $HOME/.gitconfig.local user.name $user_name
        and git config --file $HOME/.gitconfig.local user.email $user_email
        and success "moved ~/.gitconfig to ~/.gitconfig.backup"
        or abort 'failed to setup git user name and email'
    else
        # otherwise this gitconfig was already made by the dotfiles
        info "already managed by dotfiles"
    end
    # include the gitconfig.local file
    # finally make git knows this is a managed config already, preventing later
    # overrides by this script
    git config --file ~/.gitconfig.local include.path ~/.gitconfig
    and git config --file ~/.gitconfig.local dotfiles.managed true
    or abort 'failed to setup git'
end

function link_file -d "links a file keeping a backup"
    echo $argv | read -l old new backup
    if test -e $new
        set newf (readlink $new)
        if test "$newf" = "$old"
            success "skipped $old"
            return
        else
            mv $new $new.$backup
            and success moved $new to $new.$backup
            or abort "failed to backup $new to $new.$backup"
        end
    end
    mkdir -p (dirname $new)
    and ln -sf $old $new
    and success "linked $old to $new"
    or abort "could not link $old to $new"
end

function install_dotfiles
    for src in $DOTFILES_ROOT/*/*.symlink
        link_file $src $HOME/.(basename $src .symlink) backup
        or abort 'failed to link config file'
    end

    link_file $DOTFILES_ROOT/02-fish/config.fish $HOME/.config/fish/config.fish backup
    or abort fish
    link_file $DOTFILES_ROOT/nvim/AstroNvim $HOME/.config/nvim backup
    or abort astronvim
    link_file $DOTFILES_ROOT/nvim/user $HOME/.config/nvim/lua/user backup
    or abort nvim_user_config
    link_file $DOTFILES_ROOT/bat/config $HOME/.config/bat backup
    or abort bat
    link_file $DOTFILES_ROOT/htop/htoprc $HOME/.config/htop/htoprc backup
    or abort htoprc
    link_file $DOTFILES_ROOT/ssh/config.dotfiles $HOME/.ssh/config.dotfiles backup
    or abort ssh
    link_file $DOTFILES_ROOT/kitty/config $HOME/.config/kitty backup
    or abort kitty
    link_file $DOTFILES_ROOT/btop/config $HOME/.config/btop backup
    or abort btop
    link_file $DOTFILES_ROOT/lazygit/config $HOME/.config/lazygit backup
    or abort lazygit
    link_file $DOTFILES_ROOT/gitui/config $HOME/.config/gitui backup
    or abort gitui
    link_file $DOTFILES_ROOT/k9s/config $HOME/.config/k9s backup
    or abort k9s
    link_file $DOTFILES_ROOT/zellij/config $HOME/.config/zellij backup
    or abort zellij
end

curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher
and success fisher
or abort fisher

install_dotfiles
and success dotfiles
or abort dotfiles

setup_gitconfig
and success gitconfig
or abort gitconfig

fisher update
and success plugins
or abort plugins

mkdir -p ~/.config/fish/completions/
and success completions
or abort completions

for installer in */install.fish
    $installer
    and success $installer
    or abort $installer
end

if ! grep (command -v fish) /etc/shells
    command -v fish | sudo tee -a /etc/shells
    and success 'added fish to /etc/shells'
    or abort 'setup /etc/shells'
    echo
end

test (which fish) = $SHELL
and success 'dotfiles installed/updated!'
and exit 0

chsh -s (which fish)
and success set (fish --version) as the default shell
or abort 'set fish as default shell'

set -q C_THEME
and success update_theme $C_THEME
or success update_theme dark

success 'dotfiles installed/updated!'
