#!/usr/bin/env bash

set -euo pipefail

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

NVIM_VERSION="0.11.7"
TMUX_VERSION="3.7"
NERD_FONT_VERSION="3.4.0"
INSTALL_NODE=false

info() {
    printf '%b\n' "${BLUE}$*${NC}"
}

success() {
    printf '%b\n' "${GREEN}$*${NC}"
}

warn() {
    printf '%b\n' "${YELLOW}$*${NC}" >&2
}

die() {
    printf '%b\n' "${RED}$*${NC}" >&2
    exit 1
}

usage() {
    cat <<'EOF'
Usage: ./dependencies.sh [--node]

  --node  Also install fnm, the latest LTS Node.js, and npm
  -h, --help
          Show this help
EOF
}

while (($#)); do
    case "$1" in
        --node)
            INSTALL_NODE=true
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            usage >&2
            die "Unknown option: $1"
            ;;
    esac
    shift
done

case "$(uname -s)" in
    Darwin)
        OS="macOS"
        ;;
    Linux)
        command -v apt-get >/dev/null 2>&1 ||
            die "Linux is supported through apt-get (Debian/Ubuntu) only."
        OS="Linux"
        ;;
    *)
        die "Unsupported operating system: $(uname -s)"
        ;;
esac

case "$(uname -m)" in
    x86_64|amd64)
        NVIM_ARCH="x86_64"
        ;;
    arm64|aarch64)
        NVIM_ARCH="arm64"
        ;;
    *)
        die "Unsupported CPU architecture: $(uname -m)"
        ;;
esac

info "Detected OS: $OS ($(uname -m))"

install_apt_packages() {
    local -a sudo_cmd=()

    if ((EUID != 0)); then
        command -v sudo >/dev/null 2>&1 || die "sudo is required to install apt packages."
        sudo_cmd=(sudo)
    fi

    "${sudo_cmd[@]}" apt-get update
    "${sudo_cmd[@]}" apt-get install -y \
        bison build-essential ca-certificates curl fontconfig fzf git \
        libevent-dev libncurses-dev pkg-config ripgrep unzip vim zsh \
        zsh-autosuggestions zsh-syntax-highlighting
}

install_nvim_linux() {
    local archive_url
    local install_root="$HOME/.local/opt"
    local install_dir="$install_root/nvim-$NVIM_VERSION"
    local tmp

    archive_url="https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-${NVIM_ARCH}.tar.gz"
    tmp="$(mktemp -d)"
    curl -fsSL "$archive_url" -o "$tmp/nvim.tar.gz"
    tar -xzf "$tmp/nvim.tar.gz" -C "$tmp"

    mkdir -p "$install_root" "$HOME/.local/bin"
    rm -rf "$install_dir"
    mv "$tmp/nvim-linux-$NVIM_ARCH" "$install_dir"
    ln -sfn "$install_dir/bin/nvim" "$HOME/.local/bin/nvim"
    rm -rf "$tmp"

    success "Neovim $NVIM_VERSION installed in $install_dir"
}

install_uv_linux() {
    curl -LsSf https://astral.sh/uv/install.sh | sh
    success "uv installed"
}

install_font_linux() {
    local font_dir="$HOME/.local/share/fonts/JetBrainsMonoNerdFont"
    local tmp

    tmp="$(mktemp -d)"
    curl -fsSL \
        "https://github.com/ryanoasis/nerd-fonts/releases/download/v${NERD_FONT_VERSION}/JetBrainsMono.zip" \
        -o "$tmp/font.zip"
    unzip -q "$tmp/font.zip" -d "$tmp/font"
    mkdir -p "$font_dir"
    find "$tmp/font" -type f -name '*.ttf' -exec cp -f '{}' "$font_dir/" \;
    fc-cache -f
    rm -rf "$tmp"

    success "JetBrains Mono Nerd Font $NERD_FONT_VERSION installed"
}

install_tmux_linux() {
    local jobs
    local tmp

    jobs="$(getconf _NPROCESSORS_ONLN 2>/dev/null || printf '1')"
    tmp="$(mktemp -d)"
    curl -fsSL \
        "https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz" \
        -o "$tmp/tmux.tar.gz"
    tar -xzf "$tmp/tmux.tar.gz" -C "$tmp"

    if ! (
        cd "$tmp/tmux-$TMUX_VERSION"
        ./configure --enable-sixel
        make -j"$jobs"
        if ((EUID == 0)); then
            make install
        else
            sudo make install
        fi
    ); then
        rm -rf "$tmp"
        die "Failed to build tmux $TMUX_VERSION"
    fi

    rm -rf "$tmp"
    success "$(/usr/local/bin/tmux -V) installed with sixel support"
}

install_brew_packages() {
    command -v brew >/dev/null 2>&1 ||
        die "Homebrew is required. Install it from https://brew.sh and rerun this script."

    brew update
    brew install curl fzf git neovim ripgrep tmux unzip uv vim \
        zsh-autosuggestions zsh-syntax-highlighting
    brew install --cask font-jetbrains-mono-nerd-font
}

configure_fnm_shell() {
    local shell_name="${SHELL:-}"
    local config_file
    local init_line

    shell_name="${shell_name##*/}"
    case "$shell_name" in
        bash)
            config_file="$HOME/.bashrc"
            init_line='eval "$(fnm env --use-on-cd --shell bash)"'
            ;;
        zsh)
            config_file="$HOME/.zshrc"
            init_line='eval "$(fnm env --use-on-cd --shell zsh)"'
            ;;
        fish)
            config_file="$HOME/.config/fish/config.fish"
            init_line='fnm env --use-on-cd --shell fish | source'
            mkdir -p "$(dirname "$config_file")"
            ;;
        *)
            warn "fnm was installed, but shell setup is not available for: $shell_name"
            return
            ;;
    esac

    touch "$config_file"
    if ! grep -Fq 'fnm env --use-on-cd' "$config_file"; then
        {
            printf '\n# fnm (Node.js version manager)\n'
            printf '%s\n' "$init_line"
        } >>"$config_file"
        success "Added fnm initialization to $config_file"
    fi
}

install_node_linux() {
    curl -fsSL https://fnm.vercel.app/install | bash
    export PATH="${XDG_DATA_HOME:-$HOME/.local/share}/fnm:$PATH"
}

install_node() {
    if [[ "$OS" == "macOS" ]]; then
        brew install fnm
    else
        install_node_linux
    fi

    configure_fnm_shell
    eval "$(fnm env --shell bash)"
    fnm install --lts --use
    fnm default "$(fnm current)"
    success "Node $(node --version) and npm $(npm --version) installed through fnm"
}

if [[ "$OS" == "macOS" ]]; then
    install_brew_packages
else
    install_apt_packages
    install_nvim_linux
    install_uv_linux
    install_font_linux
    install_tmux_linux
fi

if [[ "$INSTALL_NODE" == true ]]; then
    install_node
fi

success "Dependency installation complete"
if [[ ":$PATH:" != *":$HOME/.local/bin:"* && "$OS" == "Linux" ]]; then
    warn "Add $HOME/.local/bin to PATH before using nvim or uv."
fi
info 'To make Zsh your login shell, run: chsh -s "$(command -v zsh)"'
