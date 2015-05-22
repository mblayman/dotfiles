#!/bin/bash

# Run all commands from dotfiles.
cd "$(dirname "$0")"

# Use absolute paths.
DOTFILES_ROOT="$(pwd)"

# Make bash finicky.
set -e

source "$DOTFILES_ROOT/lib/logging.sh"

link () {
    local src="$1"
    local dest="$2"
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
    link "$DOTFILES_ROOT/vim" "$HOME/.vim.test"
    link "$DOTFILES_ROOT/vim" "$HOME/goboom"
    success "You're golden!"
}

main
