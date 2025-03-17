#!/bin/bash

# Run all commands from dotfiles.
cd "$(dirname "$0")"

# Use absolute paths.
DOTFILES_ROOT="$(pwd)"

# Make bash finicky.
set -e

os_name=$(uname)

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

    if [[ "$os_name" == "Darwin" ]]; then
        brew bundle --file $DOTFILES_ROOT/Brewfile
    else
        sudo apt-get install -y \
            clang \
            curl \
            direnv \
            fzf \
            neovim \
            ripgrep \
            zsh
    fi

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

    # Handle nerd font install.
    if [[ "$os_name" == "Linux" ]]; then
        if [ ! -f ~/.local/share/fonts/UbuntuMonoNerdFont-Regular.ttf ]; then
            info "Install Ubuntu Mono nerd font."
            mkdir -p ~/.local/share/fonts
            curl -L -o ~/.local/share/fonts/UbuntuMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/UbuntuMono.zip
            unzip ~/.local/share/fonts/UbuntuMono.zip -d ~/.local/share/fonts
            rm ~/.local/share/fonts/UbuntuMono.zip
            fc-cache -f -v
        else
            success "Ubuntu Mono nerd font is available."
        fi
    fi

    if command -v starship &> /dev/null; then
        success "starship is available."
    else
        info "Fetching starship."
        curl -sS https://starship.rs/install.sh | sh
    fi

    info "Symlink ALL THE THINGS!"
    link "$DOTFILES_ROOT/.bash_profile" "$HOME/.bash_profile"
    link "$DOTFILES_ROOT/git/.gitconfig" "$HOME/.gitconfig"
    link "$DOTFILES_ROOT/zsh/zshenv" "$HOME/.zshenv"
    link "$DOTFILES_ROOT/zsh/zshrc" "$HOME/.zshrc"
    mkdir -p "$HOME/.config"
    link "$DOTFILES_ROOT/nvim" "$HOME/.config/nvim"
    link "$DOTFILES_ROOT/starship.toml" "$HOME/.config/starship.toml"

    info "Watch out for VPN issues!"
    info "Install Neovim plugins."
    nvim --headless +Lazy +q
    echo ""

    # iTerm2 config
    # Appearance > Tabs > Uncheck "Show activity indicator"
    # Profiles > General > Radio "Reuse previous session's directory"
    # Profiles > Colors > Color Presets... > Import and Use "Monokai Remastered"
    # Profiles > Text > Font > Use "UbuntuMono Nerd Font Mono" at 14pt
    # Profiles > Terminal > Check "Silence bell"

    if [[ "$os_name" == "Darwin" ]]; then
        info "Check your iTerm2 configuration."
    fi

    success "You're golden!"
}

main
