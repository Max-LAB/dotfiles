#!/usr/bin/env bash
set -euo pipefail

echo "==> Starting dotfiles bootstrap"

# Install chezmoi if missing
if ! command -v chezmoi >/dev/null 2>&1; then
  echo "==> Installing chezmoi"
  sh -c "$(curl -fsLS get.chezmoi.io)"
fi

# Make sure chezmoi is in PATH for this session
export PATH="$HOME/.local/bin:$PATH"

# Sanity check
if ! command -v chezmoi >/dev/null 2>&1; then
  echo "ERROR: chezmoi not found in PATH"
  exit 1
fi


# 2. macOS: install Homebrew if missing
if [[ "$OSTYPE" == "darwin"* ]]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "==> Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c \
      "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # ensure brew is available in this shell
    if [[ -x /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  else
    echo "==> Homebrew already installed"
  fi
fi

# 3. Initialize and apply chezmoi
echo "==> Applying chezmoi configuration"
chezmoi init --apply Max-LAB

echo "==> Bootstrap completed successfully"
