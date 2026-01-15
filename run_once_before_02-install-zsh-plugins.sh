#!/bin/bash

# Script to install Zsh plugins
# Usage: ./install-zsh-plugins.sh

set -e

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
PLUGINS_DIR="$ZSH_CUSTOM/plugins"

echo "================================================"
echo "Installing Zsh Plugins"
echo "================================================"

# Check if Oh My Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Error: Oh My Zsh is not installed!"
    echo "Please install Oh My Zsh first: https://ohmyz.sh/"
    exit 1
fi

# Create plugins directory if it doesn't exist
mkdir -p "$PLUGINS_DIR"

# Function to install a plugin
install_plugin() {
    local plugin_name=$1
    local repo_url=$2
    local plugin_path="$PLUGINS_DIR/$plugin_name"
    
    if [ -d "$plugin_path" ]; then
        echo "✓ $plugin_name is already installed"
        return 0
    fi
    
    echo "Installing $plugin_name..."
    if git clone "$repo_url" "$plugin_path"; then
        echo "✓ $plugin_name installed successfully"
    else
        echo "✗ Failed to install $plugin_name"
        return 1
    fi
}

echo ""
echo "Installing plugins..."
echo ""

# Install zsh-syntax-highlighting
install_plugin "zsh-syntax-highlighting" \
    "https://github.com/zsh-users/zsh-syntax-highlighting.git"

# Install zsh-autosuggestions
install_plugin "zsh-autosuggestions" \
    "https://github.com/zsh-users/zsh-autosuggestions.git"

# Install you-should-use
install_plugin "you-should-use" \
    "https://github.com/MichaelAquilina/zsh-you-should-use.git"

# Install kubetail
install_plugin "kubetail" \
    "https://github.com/johanhaleby/kubetail.git"

echo ""
echo "================================================"
echo "✓ All plugins installed successfully!"
echo "================================================"
echo ""
echo "Installation complete!"