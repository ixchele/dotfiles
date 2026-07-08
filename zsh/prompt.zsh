# COLORS
local BLACK="%F{black}"
local RED="%F{red}"
local GREEN="%F{green}"
local YELLOW="%F{yellow}"
local BLUE="%F{blue}"
local MAGENTA="%F{magenta}"
local CYAN="%F{cyan}"
local WHITE="%F{white}"
local B_BLACK="%K{black}"
local B_RED="%K{red}"
local B_GREEN="%K{green}"
local B_YELLOW="%K{yellow}"
local B_BLUE="%K{blue}"
local B_MAGENTA="%K{magenta}"
local B_CYAN="%K{cyan}"
local B_WHITE="%K{white}"
local RESET="%f"

local git_branch() {
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
