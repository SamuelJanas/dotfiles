# Dotfiles

This repository contains configuration files for Neovim, tmux, and Zsh, along
with setup scripts for environment initialization.

## Setup

Install dependencies, link the dotfiles, and install TPM:

```bash
./dependencies.sh
./setup.sh
```

On Linux, stable command-line tools come from apt.
Neovim 0.11.7 and JetBrains Mono Nerd Font come from their official GitHub
releases, while uv uses its official installer. The prebuilt tmux 3.6b Linux
x86_64 binary is installed under `~/.local/bin`.

On macOS, dependencies and the Nerd Font are installed with Homebrew.

## Zsh

The Zsh configuration includes shared deduplicated history, history-based
autosuggestions, syntax highlighting, fzf bindings, menu completion, Starship,
fnm, and small helpers migrated from Fish.

After installing and linking the dotfiles, make Zsh the login shell:

```bash
chsh -s "$(command -v zsh)"
```

Start a new login session afterward. Scripts that require Bash should continue
to use a Bash shebang (`#!/usr/bin/env bash`); changing the interactive shell
does not change how those scripts run.

Persistent PATH entries belong near the top of `.zshrc`. For a temporary entry
in the current shell, use `path-add ~/some/bin`; inspect it with `path-show`.

### Optional Node.js

Install fnm, the latest LTS Node.js, and its bundled npm:

```bash
./dependencies.sh --node
./setup.sh
```
