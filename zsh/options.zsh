# Autostart Tmux
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -z "$NVIM" ]] && [[ -z "$VIM" ]]; then
    if [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]; then
        exec tmux new-session -A -s remote
    else
        exec tmux new-session -A -s dev
    fi
fi


# screen saver
eval "$(drift shell-init zsh)"
