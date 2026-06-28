#!/usr/bin/env bash

set -euo pipefail

# Output colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
TPM_DIR="$HOME/.tmux/plugins/tpm"
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo -e "${BLUE}Setting up dotfiles...${NC}"
mkdir -p "$BACKUP_DIR"

create_symlink() {
    local src="$1" dest="$2"
    if [[ -e "$dest" || -L "$dest" ]]; then
        mv "$dest" "$BACKUP_DIR/"
    fi
    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
    echo -e "${GREEN}Linked: $dest -> $src${NC}"
}

NVIM_SRC="nvim"
[[ "${1:-}" == "--mini" ]] && NVIM_SRC="nvim-mini"

command -v git >/dev/null 2>&1 || {
    echo "git is required to install shell and tmux plugins. Run ./dependencies.sh first." >&2
    exit 1
}

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${BLUE}Installing Oh My Zsh...${NC}"
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://install.ohmyz.sh/)"
    echo -e "${GREEN}Oh My Zsh installed${NC}"
fi

if [ ! -d "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions" ]; then
    echo -e "${BLUE}Installing zsh-autosuggestions...${NC}"
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"
fi

create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/$NVIM_SRC" "$HOME/.config/nvim"
create_symlink "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"

PLUG_VIM="$HOME/.vim/autoload/plug.vim"
if [ ! -f "$PLUG_VIM" ]; then
    echo -e "${BLUE}Installing vim-plug...${NC}"
    curl -fLo "$PLUG_VIM" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo -e "${GREEN}vim-plug installed${NC}"
fi

if [ ! -d "$TPM_DIR" ]; then
    echo -e "${BLUE}Installing TPM...${NC}"
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    echo -e "${GREEN}TPM installed${NC}"
fi

echo -e "${GREEN}Dotfiles setup complete${NC}"
echo -e "${BLUE}Start tmux and press prefix + I to install plugins${NC}"
echo -e "${BLUE}To make Zsh your login shell, run: chsh -s \"\$(command -v zsh)\"${NC}"
