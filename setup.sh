#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${BLUE}Setting up your dotfiles...${NC}"

# Create backup directory
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
echo -e "${BLUE}Created backup directory at: $BACKUP_DIR${NC}"

# Function to create symlinks
create_symlink() {
    local src="$1"
    local dest="$2"
    
    # Backup existing file/directory if it exists
    if [ -e "$dest" ]; then
        echo -e "${BLUE}Backing up $dest to $BACKUP_DIR${NC}"
        mv "$dest" "$BACKUP_DIR/"
    fi
    
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$dest")"
    
    # Create the symlink
    ln -sf "$src" "$dest"
    echo -e "${GREEN}Created symlink: $dest -> $src${NC}"
}

# Create symlinks
create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Install tmux plugin manager if not already installed
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
    echo -e "${BLUE}Installing tmux plugin manager...${NC}"
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    echo -e "${GREEN}Installed tmux plugin manager${NC}"
fi

echo -e "${GREEN}Dotfiles setup complete!${NC}"
echo -e "${BLUE}Run the installation script to install dependencies:${NC}"
echo -e "${BLUE}  bash $DOTFILES_DIR/scripts/install.sh${NC}"
echo -e "${BLUE}After installation, start tmux and press prefix + I to install tmux plugins.${NC}"
