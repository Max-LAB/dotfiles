#!/bin/bash
set -e

echo "================================================"
echo "DevPod Bootstrap - Setting up your environment"
echo "================================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 1. Install chezmoi
if ! command -v chezmoi &> /dev/null; then
    log_info "Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
    export PATH="$HOME/.local/bin:$PATH"
else
    log_info "chezmoi is already installed"
fi

# 2. Detect if we're in the chezmoi source directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 3. Apply dotfiles
if [ -f "$SCRIPT_DIR/.chezmoi.toml.tmpl" ] || [ -f "$SCRIPT_DIR/dot_zshrc" ] || [ -f "$SCRIPT_DIR/config/zsh/dot_zshrc" ]; then
    log_info "Initializing from source directory: $SCRIPT_DIR"
    
    # Set default values for non-interactive setup
    export CHEZMOI_DATA_EMAIL="${GIT_EMAIL:-user@example.com}"
    export CHEZMOI_DATA_NAME="${GIT_NAME:-DevPod User}"
    
    chezmoi init --apply --source="$SCRIPT_DIR" --force
else
    log_error "Cannot find chezmoi configuration files"
    exit 1
fi

# 4. Install zsh if not present
if ! command -v zsh &> /dev/null; then
    log_info "Installing zsh..."
    if [ -f /etc/debian_version ]; then
        sudo apt-get update && sudo apt-get install -y zsh
    elif [ -f /etc/redhat-release ]; then
        sudo dnf install -y zsh
    else
        log_warn "Unknown OS, please install zsh manually"
    fi
fi

# 5. Change default shell to zsh (if not already)
if [ "$SHELL" != "$(which zsh)" ]; then
    log_info "Changing default shell to zsh..."
    if command -v chsh &> /dev/null; then
        chsh -s "$(which zsh)" || log_warn "Could not change shell automatically"
    else
        log_warn "chsh not available, please change shell manually"
    fi
fi

echo ""
echo "================================================"
echo -e "${GREEN}✓ Setup complete!${NC}"
echo "================================================"
echo ""
echo "Next steps:"
echo "  1. Start zsh: exec zsh"
echo "  2. Or logout and login again to use zsh by default"
echo ""
echo "To update dotfiles later:"
echo "  chezmoi update -v"
echo ""
