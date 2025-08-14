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

build_prompt() {
  local RED="%F{red}"
  local GREEN="%F{green}"
  local BLUE="%F{blue}"
  local MAGENTA="%F{magenta}"
  local CYAN="%F{cyan}"
  local RESET="%f"

  # Branch Git
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

  # Statut
  local status="[%F{%(?.green.red)}%(?.✓.✗)%f]"

  # Heure
  local hour="[${CYAN}%D{%I:%M}${RESET}]"

  # Utilisateur et host
  local user_host="(${GREEN}%n@%m${RESET})"

  # Chemin
  local path="${BLUE}%~${RESET}"

  # Branche Git si existante
  local branch_display=""
  if [[ -n $branch ]]; then
    branch_display="(${MAGENTA}  branch:$branch${RESET})"
  fi

  # Construction du prompt
  PROMPT="${status} ${user_host} ${hour} ${branch_display}
${RED}  ${RESET}: ${path} ${BLUE}❯${RESET} "
}

# Appeler build_prompt avant chaque prompt
precmd() { build_prompt }
