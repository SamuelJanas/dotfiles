export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(
    git
    fzf
    zsh-autosuggestions
    tmux
    zsh-autocomplete
)

bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word

source "$ZSH/oh-my-zsh.sh"

. "$HOME/.local/bin/env"
export PATH="$HOME/.local/share/fnm:$PATH"
export EDITOR="${commands[nvim]:-vim}"
export VISUAL="$EDITOR"


if (( $+commands[fnm] )); then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

config() {
    git -C "$HOME/dotfiles" "$@"
}

ave() {
    source .venv/bin/activate
}

start() {
    command explorer.exe "${1:-.}"
}

if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
fi

# # Oh My Zsh does not provide autosuggestions itself.
# [[ -r /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
#     source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
