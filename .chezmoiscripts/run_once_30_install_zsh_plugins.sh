#!/usr/bin/env bash
set -e

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

plugins=(
  zsh-autosuggestions
  zsh-syntax-highlighting
)

for plugin in "${plugins[@]}"; do
  if [[ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]]; then
    git clone "https://github.com/zsh-users/$plugin.git" \
      "$ZSH_CUSTOM/plugins/$plugin"
  fi
done
