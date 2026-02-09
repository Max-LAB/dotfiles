#!/usr/bin/env bash
set -e

if ! command -v zsh >/dev/null 2>&1; then
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt-get update
    sudo apt-get install -y zsh
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install zsh
  fi
fi

# Path to zsh
ZSH_PATH=$(which zsh)

# Only try to change shell if needed
if [[ "$SHELL" != "$ZSH_PATH" ]]; then
  # Check if we are in an interactive terminal
  if [[ -t 1 ]]; then
    # Ensure the user exists in /etc/passwd
    if id "$USER" >/dev/null 2>&1; then
      echo "==> Changing default shell to zsh"
      chsh -s "$ZSH_PATH" "$USER" || echo "==> chsh failed, please run manually"
      echo "==> Logout and login required for shell change to take effect"
    else
      echo "==> Skipping chsh: user '$USER' not found in /etc/passwd"
    fi
  else
    echo "==> Non-interactive session detected, skipping chsh"
  fi
fi