# Dotfiles

This repository contains configuration files for Neovim and tmux, along with setup scripts for environment initialization.

## setup

- `setup`: Creates symlinks for `.tmux.conf` and Neovim config (`nvim/` or `nvim-minimal/`) into the appropriate locations in `$HOME`. 
Also installs the tmux plugin manager if missing.

- `dependencies`: Installs necessary packages for macOS and Debian-based systems (Ubuntu/Mint). Includes options for minimal setups or installing `yarn`.

### Basic setup

```bash
bash dependencies
bash setup
```

### Minimal setup

```bash
bash dependencies --minimal
bash setup --minimal
```

### Install with yarn

```bash
bash dependencies --yarn
```
