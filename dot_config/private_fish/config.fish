set fish_greeting

function pls
	while not $argv
	end
end

function plsboot
	while not ssh $argv
	end
end

alias cclip="xclip -selection clipboard"

set -xp PATH $HOME/.local/bin

if status is-interactive
	if [ -z $__prompt_primary_color ]
		set -g __prompt_primary_color cyan
	end

	if [ -z $__prompt_secondary_color ]
		set -g __prompt_secondary_color purple
	end

	if [ -z $__prompt_error_color ]
		set -g __prompt_error_color red
	end

	function last_history_item; echo $history[1]; end
	abbr -a !! --position anywhere --function last_history_item

	function prompt_repaint --on-signal WINCH
		commandline -f repaint
	end

	function fish_prompt
		set last_status $status
		set prefix (set_color "$__prompt_secondary_color")'['(prompt_pwd -d 0)']'(set_color reset)
		if [ $last_status -eq 0 ]
			set trailer '$ '
		else
			set trailer (set_color $__prompt_error_color)'$ '
		end

		set suffix (set_color "$__prompt_primary_color")(whoami)@(hostname)$trailer(set_color reset)
		set full_prompt $prefix $suffix
		set prompt_length (string length "$full_prompt")
		set wrap_threshold (math $(tput cols) "* 5/8")
		if [ "$prompt_length" -gt "$wrap_threshold" ]
			echo "$prefix"
			echo "$suffix"
		else
			echo "$full_prompt"
		end
	end

	function fish_title
		# If we're connected via ssh, we print the hostname.
		set -l ssh
		set -q SSH_TTY
		and set ssh "["(prompt_hostname | string sub -l 10 | string collect)"]"
		# An override for the current command is passed as the first parameter.
		# This is used by `fg` to show the true process name, among others.
		if set -q argv[1]
			echo -- $ssh (string sub -l 20 -- $argv[1]) (prompt_pwd -d 1 -D 1)
		else
			# Don't print "fish" because it's redundant
			set -l command (status current-command)
			if test "$command" = fish
				set command
			end
			# Modified from the default to show the full path
			echo -- $ssh (string sub -l 20 -- $command) (prompt_pwd -d0)
		end
	end

	fzf --fish |source

	set -x FZF_CTRL_R_OPTS "--bind 'ctrl-r:down' --bind 'ctrl-s:up' --layout=reverse"
end


