#!/usr/bin/env bash
function readLocations() {
	echo "Symlinking to the following locations..."
	for key in "${!locations[@]}"; do
		echo "$key -> ${locations[$key]}"
	done
	echo ""
}

getopts "f" force
declare -A locations=(
					  ["ctags"]="$HOME/.ctags"\
					  ["i3-config"]="$HOME/.config/i3/config"\
					  ["polybar-config"]="$HOME/.config/polybar/config"\
					  ["rofi"]="$HOME/.config/rofi"\
					  ["scripts"]="$HOME/.local/dotfile-scripts"\
					  ["terminalrc"]="$HOME/.config/xfce4/terminal/terminalrc"\
					  ["vimrc"]="$HOME/.vimrc"\
					  ["zshrc"]="$HOME/.zshrc")

readLocations

satisfied="n"
while [[ $satisfied != "y" ]]; do
	locationsSet=false
	read -p "Are you satisfied with these locations? (y/n) [y] " satisfied
	while [[ $locationsSet == false ]]; do
		if [[ $satisfied == "no" ]] || [[ $satisfied == "n" ]]; then
			read -p "Name of file to change: " nameToChange
			if [[ ! -z ${locations[$nameToChange]} ]]; then
				read -p "New path for this file: " newPath
				locations[$nameToChange]=$newPath
				locationsSet=true
				readLocations
			else
				echo "Not found."
			fi
		elif [[ $satisfied == "" ]] || [[ $satisfied == "yes" ]] || [[ $satisfied == "y" ]]; then
			locationsSet=true
			satisfied="y"
		fi
	done
done

status=0
for key in "${!locations[@]}"; do
	fullPath=$(readlink -f $key)
	if [[ $force == "f" ]]; then
		ln -sf $fullPath ${locations[$key]}
	else
		ln -s $fullPath ${locations[$key]}
	fi
	#If we just set status equal to $?, it checks the status of $status == 0, rather than our ln command
	newStatus=$?
	if [[ $status == 0 ]]; then
		status=$newStatus
	fi
done

if [[ $status == 0 ]]; then
	echo "Dotfiles have been installed!"
else
	echo "Some dotfiles failed to install, probably due to existing symlinks. If you wish to overwrite your existing files, please run this again with the -f flag."
fi
