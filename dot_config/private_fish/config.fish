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

	fzf --fish |source

	set -x FZF_CTRL_R_OPTS "--bind 'ctrl-r:down' --bind 'ctrl-s:up' --layout=reverse"
end
