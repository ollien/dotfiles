#!/usr/bin/env bash
function readLocations() {
	echo "Symlinking to the following locations..."
	for key in "${!locations[@]}"; do
		echo "$key -> ${locations[$key]}"
	done
	echo ""
}

getopts "f" force
declare -A locations=(["zshrc"]="$HOME/.zshrc"\
					  ["vimrc"]="$HOME/.vimrc"\
					  ["i3-config"]="$HOME/.config/i3/config"\
					  ["terminalrc"]="$HOME/.config/xfce4/terminal/terminalrc"\
					  ["gtkrc-2.0"]="$HOME/.gtkrc-2.0"\
					  ["scripts"]="$HOME/.local/dotfile-scripts"\
					  ["rofi"]="$HOME/.config/rofi")
readLocations

satisfied="n"
while [[ $satisfied != "y" ]]; do
	done=false
	read -p "Are you satisfied with these locations? (y/n) [y] " satisfied
	while [[ $done = false ]]; do
		if [[ $satisfied == "no" ]] || [[ $satisfied == "n" ]]; then
			read -p "Name of file to change: " nameToChange
			if [[ ! -z ${locations[$nameToChange]} ]]; then
				read -p "New path for this file: " newPath
				locations[$nameToChange]=$newPath
				done=true
				readLocations
			else
				echo "Not found."
			fi
		elif [[ $satisfied == "" ]] || [[ $satisfied == "yes" ]] || [[ $satisfied == "y" ]]; then
			done=true
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
