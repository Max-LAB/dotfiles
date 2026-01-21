#!/usr/bin/env bash
set -e

if command -v zsh >/dev/null 2>&1; then
  exit 0
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt update
  sudo apt install -y zsh
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew install zsh
fi

chsh -s "$(command -v zsh)"
