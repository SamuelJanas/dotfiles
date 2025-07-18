#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

OS="Unknown"
if [[ "$(uname)" == "Darwin" ]]; then
    OS="macOS"
elif [ -f /etc/os-release ]; then
    . /etc/os-release
    [[ "$ID" == "ubuntu" || "$ID_LIKE" == *debian* ]] && OS="Debian"
fi

echo -e "${BLUE}Detected OS: $OS${NC}"

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_font() {
    FONT_DIR="$HOME/.local/share/fonts"
    [[ "$OS" == "macOS" ]] && FONT_DIR="$HOME/Library/Fonts"
    mkdir -p "$FONT_DIR"

    TMP=$(mktemp -d)
    curl -fsSL -o "$TMP/font.zip" \
        https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
    unzip -q "$TMP/font.zip" -d "$TMP/fonts"
    cp "$TMP/fonts"/*.ttf "$FONT_DIR/"
    [[ "$OS" != "macOS" ]] && fc-cache -f
    rm -rf "$TMP"

    echo -e "${GREEN}JetBrains Mono Nerd Font installed${NC}"
}

install_deps_debian() {
    sudo apt update
    sudo apt install -y \
        curl wget tmux python3 python3-pip \
        ripgrep fzf unzip build-essential
}

install_deps_macos() {
    brew update
    brew install curl wget tmux python3 ripgrep fzf neovim
}

install_yarn() {
    if [[ "$OS" == "macOS" ]]; then
        brew install yarn
    elif [[ "$OS" == "Debian" ]]; then
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
        sudo apt update && sudo apt install -y yarn
    fi
    echo -e "${GREEN}Yarn installed${NC}"
}

install_minimal() {
    if [[ "$OS" == "macOS" ]]; then
        brew update
        brew install tmux fzf
    elif [[ "$OS" == "Debian" ]]; then
        sudo apt update
        sudo apt install -y tmux fzf
    fi
}

case "$1" in
    --minimal)
        install_minimal
        ;;
    --yarn)
        [[ "$OS" == "Unknown" ]] && { echo -e "${RED}Unsupported OS${NC}"; exit 1; }
        [[ "$OS" == "Debian" ]] && install_deps_debian
        [[ "$OS" == "macOS" ]] && install_deps_macos
        install_yarn
        install_font
        ;;
    *)
        [[ "$OS" == "Unknown" ]] && { echo -e "${RED}Unsupported OS${NC}"; exit 1; }
        [[ "$OS" == "Debian" ]] && install_deps_debian
        [[ "$OS" == "macOS" ]] && install_deps_macos
        install_font
        ;;
esac

