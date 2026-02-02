export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/dotfile-scripts:$PATH"

alias cclip='xclip -selection clipboard'

pls() {
  while ! "$@"; do
    :
  done
}

plsboot() {
  while ! ssh "$@"; do
    :
  done
}

take() {
  [[ -n ${1} ]] && mkdir -p ${1} && builtin cd ${1}
}

unsetopt autocd
setopt clobber
