#!/bin/bash

# Run all commands from dotfiles.
cd "$(dirname "$0")"

# Use absolute paths.
DOTFILES_ROOT="$(pwd)"

# Make bash finicky.
set -e

source "$DOTFILES_ROOT/lib/logging.sh"

check_for_tools () {
    info "Check for all the required tools."
    hash git 2>/dev/null || failure "git is not installed."
    success "All required tools are installed."
}

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

    check_for_tools

    info "Boostrapping Zsh."
    if [[ $SHELL == "/bin/zsh" ]]; then
        success "zsh is available."
    else
        failure "Zsh is not your shell. Set with 'chsh -s /bin/zsh'."
    fi
    local omz="$HOME/.oh-my-zsh"
    if [ -d "$omz" ]; then
        success "Oh My Zsh is available."
    else
        git clone --depth=1 --quiet \
            https://github.com/robbyrussell/oh-my-zsh.git "$omz"
        success "Fetched Oh My Zsh."
    fi

    info "Bootstrapping Vim."
    local vimplug="$DOTFILES_ROOT/vim/autoload/plug.vim"
    if [ -e "$vimplug" ]; then
        success "vim-plug is available."
    else
        curl -fLo "$vimplug" --silent \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        success "Fetched vim-plug."
    fi

    info "Symlink ALL THE THINGS!"
    link "$DOTFILES_ROOT/vim" "$HOME/.vim"
    link "$DOTFILES_ROOT/.bash_profile" "$HOME/.bash_profile"
    link "$DOTFILES_ROOT/git/.gitconfig" "$HOME/.gitconfig"
    link "$DOTFILES_ROOT/zsh/zshenv" "$HOME/.zshenv"
    link "$DOTFILES_ROOT/zsh/zshrc" "$HOME/.zshrc"

    info "Manual steps:"
    info " - Open Vim and run :PlugInstall."
    success "You're golden!"
}

main
