
if ! which fzf &> /dev/null; then
	return 1 &> /dev/null
fi

source <(fzf --zsh)

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_T_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border=rounded --preview 'bat --style=numbers --color=always {}'"

source "$HOME/.config/fzf/tinted-fzf/bash/base16-tokyo-night-dark.config"

_fzf_compgen_path() {
	fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
	fd --type=d --hidden --exclude .git . "$1"
}
