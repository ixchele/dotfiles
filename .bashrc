#=====================================================================
#"all rights for oneperson"
#contact me for more onerealperson@icloud.com

source ~/.alias.sh
function disk_usage() {
	df -h | awk 'NR==3 {print $5}'
}
function random()
{
	if [[ $((RANDOM % 7)) -eq 0 ]]
	then
		#echo -n "⋙  "
		echo -n "❯ "
	elif [[ $((RANDOM % 3)) -eq 0 ]]
	then
	       echo -n "⇋ "	
       elif [[ $((RANDOM % 2)) -eq 0 ]]
	then
		echo -en "  "
	else
		echo -n "➟ "
	fi
}
blue='\e[01;36m'
green='\e[01;32m'
_green='\e[01;42;30m'
_blue='\e[01;46;30m'
reset='\e[00m'
red='\e[31m'
color='\e[01;32;46m'

function myplace() {
if [[ "$PWD" == "$HOME" ]]
then
	echo " "
elif [[ "$PWD" == @("$HOME"/SCRIPTS/*|"$HOME"/SCRIPTS) ]]
then
	printf " "
elif [[ "$PWD" == @("${HOME}/Desktop/correction/*"|"${HOME}/Desktop/correction") ]]
then
	printf " "
elif [[ -d .git ]]
then
	printf " "
elif [[ "$PWD" == @("$HOME"/Downloads/*|"$HOME/Downloads") ]]
then
	printf "󰉍 "
elif [[ "$PWD" == @(/media/*|"/media") ]]
then
	printf " "
elif [[ "$PWD" == @("$HOME"/Videos/*|"$HOME/Videos") ]]
then
	printf " "
elif [[ "$PWD" == "/" ]]
then
	printf " "
elif [[ "$PWD" == @("${HOME}/Pictures/Screenshots"|"${HOME}"/Pictures/Screenshots/*) ]]
then
	printf " "
else
	echo " "
fi
}

work() {
	if [[ $(tput cols) -ge 60 && $(echo "$PWD" | wc -c) -le 50 ]]
	then
		printf "$USER@ixchele"
	else
		printf "%s" $(date +%H:%M)
	fi
}




# PS1='\n\[\e[34m\]\[\e[00m\]\[\e[00;44m\]$? \[\e[00m\]\[\e[01;32m\]\[\e[00m\]\[\e[01;42;30m\] $(work) \[\e[00m\]\[\e[01;32;46m\] \[\e[00m\]\[\e[01;46;30m\]$(myplace) \w \[\e[00m\]\[\e[01;36m\]\[\e[00m\]\n\[\e[01;34m\]└──\[\e[00m\] '
#     #alias dir='dir --color=auto'
#     #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

alias xclean="/bin/bash $HOME/xclean.sh"
alias xclean="/bin/bash $HOME/xclean.sh"
