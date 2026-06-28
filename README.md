# Dotfiles

This repository contains configuration files for Neovim and tmux, along with
setup scripts for environment initialization.

## Setup

Install dependencies, link the dotfiles, and install TPM:

```bash
./dependencies.sh
./setup.sh
```

On Linux, stable command-line tools and build dependencies come from apt.
Neovim 0.11.7 and JetBrains Mono Nerd Font come from their official GitHub
releases, while uv uses its official installer. tmux 3.7 is built from its
official release tarball with sixel support and installed under `/usr/local`.

On macOS, dependencies and the Nerd Font are installed with Homebrew.

### Optional Node.js

Install fnm, the latest LTS Node.js, and its bundled npm:

```bash
./dependencies.sh --node
./setup.sh
```
