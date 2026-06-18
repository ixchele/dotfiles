source "$HOME/.alias" 
source "$HOME/.exports.zsh"

export MAIL="zbengued@student.1337.ma"

#COLORS
BLACK="%F{black}"
RED="%F{red}"
GREEN="%F{green}"
YELLOW="%F{yellow}"
BLUE="%F{blue}"
MAGENTA="%F{magenta}"
CYAN="%F{cyan}"
WHITE="%F{white}"
RESET="%f"

# Util Functions

clone-from() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Usage: clone-from <user> <repo>"
        return 1
    fi
    git clone "git@github.com:$1/$2.git"
}

# prompt

git_branch() {
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  [[ -n $branch ]] && echo "$branch"
}

PROMPT_STATUS="[%F{%(?.green.red)}%(?.✓.✗)${RESET}]"
PROMPT_HOUR="[${CYAN}%D{%H:%M}${RESET}]"
PROMPT_USER_HOST="(${BLUE}%n@%m${RESET})"
PROMPT_PATH="${BLUE}%~${RESET}"

build_prompt() {
  branch=$(git_branch)
  if [[ -n $branch ]]; then
	  PROMPT_BRANCH="(${MAGENTA}  branch:$branch${RESET})"
  else
    PROMPT_BRANCH=""
  fi

  PROMPT="${PROMPT_STATUS} ${PROMPT_USER_HOST} ${PROMPT_HOUR} ${PROMPT_BRANCH}
${RED}  ${RESET}: ${PROMPT_PATH} ${BLUE}❯${RESET} "
}
precmd() { build_prompt }


# fnm
FNM_PATH="/home/zbengued/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# clang-format
export CLANG_FORMAT_STYLE="file"
export CLANG_FORMAT_FILE="$HOME/.config/.clang-format"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Homebrew (user-only)
export HOMEBREW_PREFIX="$HOME/.linuxbrew"
export HOMEBREW_CELLAR="$HOME/.linuxbrew/Cellar"
export HOMEBREW_REPOSITORY="$HOME/.linuxbrew/Homebrew"
export PATH="$HOME/.linuxbrew/bin:$PATH"


# Homebrew zsh completion
fpath+=("$HOME/.linuxbrew/Homebrew/completions/zsh")
autoload -Uz compinit
compinit

fpath+=("$HOME/.linuxbrew/share/zsh/site-functions")
autoload -Uz compinit
compinit


# Homebrew zsh completion
fpath+=("$HOME/.linuxbrew/Homebrew/completions/zsh")
autoload -Uz compinit
compinit

# Start tmux
if [ -z "$TMUX" ]; then
  tmux attach 2> /dev/null || tmux new
fi
