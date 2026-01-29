#!/usr/bin/env bash
set -e

if ! command -v zsh >/dev/null 2>&1; then
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt update
    sudo apt install -y zsh
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install zsh
  fi
fi

ZSH_PATH="$(command -v zsh)"

if [[ "$SHELL" != "$ZSH_PATH" ]]; then
  echo "==> Changing default shell to zsh"
  chsh -s "$ZSH_PATH"
  echo "==> Logout and login required"
fi