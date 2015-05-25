#!/bin/bash

# Run all commands from dotfiles.
cd "$(dirname "$0")"

# Use absolute paths.
DOTFILES_ROOT="$(pwd)"

# Make bash finicky.
set -e

source "$DOTFILES_ROOT/lib/logging.sh"

link () {
    declare src="$1" dest="$2"
    if [ -e "$dest" ]; then
        if [ -h "$dest" ]; then
            # Kill any existing links.
            rm "$dest"
        else
            failure "$dest already exists and is not a link. Clean it up!"
        fi
    fi
    ln -s "$src" "$dest"
    success "Linked $src to $dest."
}

main () {
    info "Let's get this party started!"

    info "Symlink ALL THE THINGS!"
    link "$DOTFILES_ROOT/vim" "$HOME/.vim"
    # TODO: need aliases
    # TODO: need env vars
    # TODO: diagnostic check for commands

    info "Bootstrapping Vim."
    local vimplug="$DOTFILES_ROOT/vim/autoload/plug.vim"
    if [ -e "$vimplug" ]; then
        success "vim-plug is available."
    else
        curl -fLo "$vimplug" --silent \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        success "Fetched vim-plug."
    fi

    info "Manual steps:"
    info " - Open Vim and run :PlugInstall."
    success "You're golden!"
}

main
