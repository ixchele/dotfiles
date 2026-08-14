autoload -U add-zsh-hook 

load_python_venv() {
	local venv_files=( .*/bin/activate(ND) )
	if (( ${#venv_files[@]} > 0 )); then
		local activate_script="$PWD/${venv_files[1]}"

		local venv_dir="${activate_script%/*/*}"

		if [[ "$VIRTUAL_ENV" != "$venv_dir" ]]; then
			source "$activate_script"
		fi
		return
	fi

	if [[ -n "$VIRTUAL_ENV" ]]; then
		local project_root="${VIRTUAL_ENV%/*}"
		if [[ "$PWD" != "$project_root"* ]]; then
			deactivate
		fi
	fi
}

print_good_bye() {
	cat ~/labo/good_bye.ascii | tte wipe
}

add-zsh-hook chpwd	load_python_venv	
add-zsh-hook zshexit	print_good_bye

load_python_venv
