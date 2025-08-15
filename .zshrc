export PATH="$HOME/.local/bin:$PATH"

# Couleurs
BLACK="%F{black}"
RED="%F{red}"
GREEN="%F{green}"
YELLOW="%F{yellow}"
BLUE="%F{blue}"
MAGENTA="%F{magenta}"
CYAN="%F{cyan}"
WHITE="%F{white}"
RESET="%f"

# prompt

git_branch() {
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  [[ -n $branch ]] && echo "$branch"
}

PROMPT_STATUS='[%F{%(?.green.red)}%(?.✓.✗)%f]'
PROMPT_HOUR="[${CYAN}%D{%I:%M}${RESET}]"
PROMPT_USER_HOST="(${GREEN}%n@%m${RESET})"
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
