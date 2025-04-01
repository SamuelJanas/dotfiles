#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
elif [ "$(uname)" == "Darwin" ]; then
    OS="macOS"
else
    OS="Unknown"
fi

echo -e "${BLUE}Detected OS: $OS${NC}"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install packages on Ubuntu/Debian
install_debian() {
    echo -e "${BLUE}Updating package lists...${NC}"
    sudo apt update
    
    echo -e "${BLUE}Installing dependencies...${NC}"
    sudo apt install -y \
        git \
        curl \
        wget \
        tmux \
        build-essential \
        nodejs \
        npm \
        python3 \
        python3-pip \
        ripgrep \
        fzf \
        unzip
    
    # Install yarn
    if ! command_exists yarn; then
        echo -e "${BLUE}Installing yarn...${NC}"
        npm install -g yarn
    fi
}

install_arch() {
    echo -e "${BLUE}Updating package lists...${NC}"
    sudo pacman -Syu
    
    echo -e "${BLUE}Installing dependencies...${NC}"
    sudo pacman -S --needed \
        git \
        curl \
        wget \
        tmux \
        base-devel \
        nodejs \
        npm \
        python \
        python-pip \
        ripgrep \
        fzf \
        unzip
    
    # Install yarn
    if ! command_exists yarn; then
        echo -e "${BLUE}Installing yarn...${NC}"
        npm install -g yarn
    fi
}

install_macos() {
    # Install Homebrew if not installed
    if ! command_exists brew; then
        echo -e "${BLUE}Installing Homebrew...${NC}"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    echo -e "${BLUE}Updating Homebrew...${NC}"
    brew update
    
    echo -e "${BLUE}Installing dependencies...${NC}"
    brew install \
        git \
        curl \
        wget \
        tmux \
        node \
        yarn \
        python3 \
        ripgrep \
        fzf \
        neovim
}

install_nerd_font() {
    echo -e "${BLUE}Installing JetBrains Mono Nerd Font...${NC}"
    
    FONT_DIR=""
    if [ "$OS" == "macOS" ]; then
        FONT_DIR="$HOME/Library/Fonts"
    else
        FONT_DIR="$HOME/.local/share/fonts"
        mkdir -p "$FONT_DIR"
    fi
    
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR" || exit
    
    echo -e "${BLUE}Downloading JetBrains Mono Nerd Font...${NC}"
    curl -fLo "JetBrainsMono.zip" \
        https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
    
    echo -e "${BLUE}Extracting fonts...${NC}"
    unzip -q JetBrainsMono.zip -d jetbrainsmono
    
    echo -e "${BLUE}Installing fonts to $FONT_DIR...${NC}"
    cp jetbrainsmono/*.ttf "$FONT_DIR/"
    
    if [ "$OS" != "macOS" ]; then
        echo -e "${BLUE}Updating font cache...${NC}"
        fc-cache -f -v
    fi
    
    # Clean up
    cd - || exit
    rm -rf "$TEMP_DIR"
    
    echo -e "${GREEN}JetBrains Mono Nerd Font installed successfully!${NC}"
}

main_install() {
    # Install dependencies based on OS
    case "$OS" in
        "Ubuntu"*|"Debian"*)
            install_debian
            ;;
        "Arch"*)
            install_arch
            ;;
        "macOS")
            install_macos
            ;;
        *)
            echo -e "${RED}Unsupported OS: $OS${NC}"
            echo -e "${YELLOW}Please install the required dependencies manually:${NC}"
            echo "- git, curl, wget, tmux"
            echo "- Node.js, npm, yarn"
            echo "- Python3, pip"
            echo "- C/C++ compiler (gcc, clang)"
            echo "- ripgrep, fzf"
            exit 1
            ;;
    esac
    
    # Install Neovim if not installed
    if ! command_exists nvim; then
        echo -e "${BLUE}Installing Neovim...${NC}"
        if [ "$OS" == "macOS" ]; then
            brew install neovim
        elif [ "$OS" == "Ubuntu"* ] || [ "$OS" == "Debian"* ]; then
            sudo add-apt-repository ppa:neovim-ppa/unstable -y
            sudo apt update
            sudo apt install -y neovim
        elif [ "$OS" == "Arch"* ]; then
            sudo pacman -S neovim
        else
            echo -e "${YELLOW}Please install Neovim manually from https://github.com/neovim/neovim/releases${NC}"
        fi
    fi
    
    # Install JetBrains Mono Nerd Font
    install_nerd_font
    
    echo -e "${GREEN}All dependencies installed successfully!${NC}"
    echo -e "${BLUE}Now run the setup script to create symlinks:${NC}"
    echo -e "${BLUE}  bash setup.sh${NC}"
}

# Run the installation
main_install
