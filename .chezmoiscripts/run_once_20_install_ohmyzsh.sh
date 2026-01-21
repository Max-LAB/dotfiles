#!/usr/bin/env bash
set -e

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  exit 0
fi

export RUNZSH=no
export CHSH=no

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
