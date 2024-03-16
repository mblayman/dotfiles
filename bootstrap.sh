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

    brew bundle --file $DOTFILES_ROOT/Brewfile

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

    info "Watch out for VPN issues!"
    info "Install Neovim plugins."
    nvim --headless +PlugInstall +q

    # iTerm2 config
    # Appearance > Tabs > Uncheck "Show activity indicator"
    # Profiles > General > Radio "Reuse previous session's directory"
    # Profiles > Colors > Color Presets... > Import and Use "Monokai Remastered"
    # Profiles > Text > Font > Use "UbuntuMono Nerd Font Mono" at 14pt
    # Profiles > Terminal > Check "Silence bell"

    info "Check your iTerm2 configuration."

    success "You're golden!"
}

main
