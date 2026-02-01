#!/usr/bin/env bash
set -e

if [[ -d "$HOME/.config/oh-my-zsh" ]]; then
  exit 0
fi

export RUNZSH=no
export CHSH=no

export ZSH="$HOME/.config/oh-my-zsh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
