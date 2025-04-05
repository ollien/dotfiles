#!/usr/bin/env bash

set -euo pipefail

if [ ! $(which ansible-playbook) ]; then
  echo "Ansible is required to bootstrap this machine." >&2
  exit 1
fi

echo "Running Bootstrap Playbook..." >&2
ANSIBLE_LOCALHOST_WARNING=False ansible-playbook -K bootstrap/bootstrap.yml

echo "Applying Chezmoi..." >&2
SOURCE_DIR=$(dirname $(realpath "$BASH_SOURCE"))
if [[ ! -L "$HOME/.local/share/chezmoi" ]]; then
  ln -s $SOURCE_DIR ~/.local/share/chezmoi
fi

$HOME/.local/bin/chezmoi apply
