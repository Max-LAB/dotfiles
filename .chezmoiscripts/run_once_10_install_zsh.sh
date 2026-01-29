#!/usr/bin/env bash
set -e
echo "$OSTYPE"
if ! command -v zsh >/dev/null 2>&1; then
  if [[ "$OSTYPE" == "linux-debian"* ]] || [[ "$OSTYPE" == "linux-raspbian"* ]] || [[ "$OSTYPE" == "linux-ubuntu"* ]]; then
    sudo apt update
    sudo apt install -y zsh
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install zsh
  fi
fi

ZSH_PATH="$(command -v zsh)"

if [[ "$SHELL" != "$ZSH_PATH" ]]; then
  echo "==> Changing default shell to zsh"
  echo "==> chsh -s "$ZSH_PATH""
  echo "==> Logout and login required"
fi