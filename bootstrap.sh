#!/bin/bash

# Run all commands from dotfiles.
cd "$(dirname "$0")"

# Use absolute paths.
DOTFILES_ROOT="$(pwd)"

# Make bash finicky.
set -e

source "$DOTFILES_ROOT/lib/logging.sh"

check_for_tool () {
    declare tool="$1"
    hash "$tool" 2>/dev/null || failure "$tool is not installed."
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

    info "Check for all the required tools."
    check_for_tool "bat"
    check_for_tool "direnv"
    check_for_tool "fzf"
    check_for_tool "git"
    check_for_tool "nvim"
    check_for_tool "starship"
    # ripgrep
    check_for_tool "rg"
    success "All required tools are installed."

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

    info "Bootstrapping Neovim."
    local vimplug="$DOTFILES_ROOT/nvim/autoload/plug.vim"
    if [ -e "$vimplug" ]; then
        success "vim-plug is available for Neovim."
    else
        curl -fLo "$vimplug" \
            --silent \
            --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        success "Fetched vim-plug."
    fi

    info "Make Zee Deerectories!"
    local pip="$HOME/.pip"
    if [ -d "$pip" ]; then
        success "$pip exists."
    else
        mkdir -p "$pip"
        success "Created $pip."
    fi

    info "Symlink ALL THE THINGS!"
    link "$DOTFILES_ROOT/.bash_profile" "$HOME/.bash_profile"
    link "$DOTFILES_ROOT/git/.gitconfig" "$HOME/.gitconfig"
    link "$DOTFILES_ROOT/pip.conf" "$HOME/.pip/pip.conf"
    link "$DOTFILES_ROOT/zsh/zshenv" "$HOME/.zshenv"
    link "$DOTFILES_ROOT/zsh/zshrc" "$HOME/.zshrc"
    mkdir -p "$HOME/.config"
    link "$DOTFILES_ROOT/nvim" "$HOME/.config/nvim"
    link "$DOTFILES_ROOT/starship.toml" "$HOME/.config/starship.toml"

    info "Manual steps:"
    info " - Install nerd fonts: brew tap homebrew/cask-fonts && brew install font-ubuntu-mono-nerd-font"
    info " - Open Neovim and run :PlugInstall."
    success "You're golden!"
}

main
