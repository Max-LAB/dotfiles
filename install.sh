#!/bin/bash

# 1. Define a consistent target directory
# Using $HOME/.local/bin is the standard for both modern Linux (XDG) and macOS
BIN_DIR="$HOME/.local/bin"

# 2. Ensure the directory exists
mkdir -p "$BIN_DIR"

# 3. Inject it into the current PATH immediately
# This ensures that even if it was JUST installed, the 'command -v' check finds it
case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) export PATH="$BIN_DIR:$PATH" ;;
esac

# 4. Idempotent Install: Check if chezmoi is actually executable and available
if ! command -v chezmoi >/dev/null 2>&1; then
  echo "==> chezmoi not found. Installing to $BIN_DIR..."
  
  # The chezmoi installer is cross-platform (macOS/Linux)
  # -b flag is standard for this installer script
  if ! sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$BIN_DIR"; then
    echo "ERROR: Installation failed. Check your internet connection or permissions."
    exit 1
  fi
else
  echo "==> chezmoi is already installed at $(command -v chezmoi)"
fi

# 5. Final validation
if ! command -v chezmoi >/dev/null 2>&1; then
  echo "ERROR: chezmoi still not found in PATH after installation."
  exit 1
fi

echo "Success: chezmoi is ready to use."

# 5. macOS: install Homebrew if missing
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
