export PATH=$HOME/.local/dotfile-scripts:$PATH

HOSTNAME=$(cat /etc/hostname)
if [[ $HOSTNAME == "professor-farnsworth" ]]; then
	export GOPATH=$HOME/Documents/code/golang
	#$HOME/.config/powerline/segments is used for custom ALE powerline segment
	export PYTHONPATH=$HOME/.config/powerline/segments
	export PATH=$HOME/.local/bin:$PATH
	export PATH=/usr/local/go/bin:$PATH
	export PATH=$GOPATH/bin:$PATH
	export EDITOR=/usr/bin/vimx
	export XDG_CONFIG_HOME=$HOME/.config/
	#In order to get pasteboard functionality on Fedora, we need alias vim=vimx
	alias vim=vimx
	#Hostname unique color
	PROMPT_COLOR=006
elif [[ $HOSTNAME == "cubert" ]]; then
	export PATH=$HOME/.local/bin:$PATH
	export GOPATH=$HOME/Documents/code/golang
	export PATH=$GOPATH/bin:$PATH
	export PATH=$HOME/.local/npm/bin:$PATH
	export PATH="$HOME/.cargo/bin:$PATH"
	export EDITOR=/usr/bin/vimx
	alias vim=vimx
	PROMPT_COLOR=006
elif [[ $HOSTNAME == "bender" ]]; then
	#$HOME/.config/powerline/segments is used for custom ALE powerline segment
	export PYTHONPATH=$HOME/.config/powerline/segments
	export GOPATH=$HOME/Documents/code/golang
	export PATH=$GOPATH/bin:$PATH
	export PATH=$HOME/.local/bin:$PATH
	export PATH=$HOME/.local/npm/bin:$PATH
	export EDITOR=/usr/bin/vimx
	alias vim=vimx
	PROMPT_COLOR=003
elif [[ $HOSTNAME == "scooty-puff-jr" ]]; then
	export PYTHONPATH=$HOME/.config/powerline/segments
	export GOPATH=$HOME/Documents/code/golang
	export PATH=$GOPATH/bin:$PATH
	export PATH=$HOME/.local/bin:$PATH
	export PATH=$HOME/.local/npm/bin:$PATH
	export PATH="$HOME/.cargo/bin:$PATH"
	export EDITOR=/usr/bin/vimx
	alias vim=vimx
	PROMPT_COLOR=004
elif [[ $HOSTNAME == "planet-express-ship" ]]; then
	PROMPT_COLOR=002
elif [[ $HOSTNAME == "nibbler" ]]; then
	export PATH=$HOME/.local/bin:$PATH
	PROMPT_COLOR=009
else
	PROMPT_COLOR=006
fi

#Load zplug and various plugins
source ~/.zsh/zplug/init.zsh
zplug 'lib/completion', from:oh-my-zsh
zplug 'lib/functions', from:oh-my-zsh
zplug 'lib/history', from:oh-my-zsh
zplug 'lib/key-bindings', from:oh-my-zsh
zplug 'lib/misc', from:oh-my-zsh
zplug 'lib/spectrum', from:oh-my-zsh
zplug 'lib/theme-and-appearance', from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi
zplug load

#Enable completion system
autoload -U compinit
compinit

unsetopt histverify
unsetopt share_history
unsetopt auto_cd
setopt auto_pushd
setopt prompt_subst
setopt extended_glob

alias cclip="xclip -selection clipboard"

tabs -4

function pls() {
	until $@; do false; done
}

function plsboot() {
	until ssh $@; do false; done
}

#Generates a prompt that detects if enough space is leftover for commands. If there isn't, command entry begins on the next line.
#Currently, the prompt length must be less than 5/8 of the terminal window
PROMPT_PREFIX='%{$FG[005]%}[%~]'
PROMPT_SUFFIX='%{$FG[$PROMPT_COLOR]%}%n@%M$%{$FX[reset]%} '
BASE_PROMPT=$PROMPT_PREFIX' '$PROMPT_SUFFIX
NEWLINE_PROMPT=$PROMPT_PREFIX$'\n'$PROMPT_SUFFIX

trap 'generate_prompt' WINCH
function generate_prompt() {
	#Remove color code extras from BASE_PROMPT. Sed doesn't support the ? operator, I passed it through perl.
	export STRIPPED_PROMPT=$(echo $BASE_PROMPT |perl -pe 's/%\{.*?%\}//g')
	PROMPT_LENGTH=$(print -P $STRIPPED_PROMPT |wc -c)

	#uses -lt rather than < because < does LEXOGRAPHIC comparison
	if [[ $PROMPT_LENGTH -lt $(($(tput cols) * 5/8)) ]]; then
		export PROMPT="$BASE_PROMPT"
	else
		export PROMPT="$NEWLINE_PROMPT"
	fi

	#Fixes virtualenv names not showing up
	if [[ ! -z $VIRTUAL_ENV ]]; then
		export PROMPT="($(basename $VIRTUAL_ENV))"$PROMPT
	fi
}

#Generate a new prompt even if something changes our long path.
function precmd() {
	generate_prompt
}

generate_prompt
