#!/bin/bash

# Run all commands from dotfiles.
cd "$(dirname "$0")"

# Use absolute paths.
DOTFILES_ROOT="$(pwd)"

# Make bash finicky.
set -e

info () {
    printf "===> %s\n" "$1"
}

success () {
    printf "\033[0;32m===>\033[0m %s\n" "$1"
}

failure () {
    printf "\033[0;31m===>\033[0m %s\n" "$1"
    exit 1
}

info "hey there!"
success "look at me!"
failure "ouch"
