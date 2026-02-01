path=($HOME/.local/bin $HOME/.local/dotfile-scripts $path)
export PATH

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
