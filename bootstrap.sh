#!/usr/bin/env bash

set -euo pipefail

if [ ! $(which ansible-playbook) ]; then
  echo "Ansible is required to bootstrap this machine." >&2
  exit 1
fi

echo "Running Bootstrap Playbook..." >&2
ANSIBLE_LOCALHOST_WARNING=False ansible-playbook -K bootstrap/bootstrap.yml

echo "Applying Chezmoi..." >&2
SOURCE_DIR=$(dirname $(realpath $BASH_SOURCE))
$HOME/.local/bin/chezmoi --source "$SOURCE_DIR" apply
