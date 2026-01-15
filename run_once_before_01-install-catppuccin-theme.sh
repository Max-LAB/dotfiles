#!/bin/bash

# Script to install Catppuccin theme for Zsh (JannoTjarks version)
# Usage: ./install-catppuccin-theme.sh

set -e

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
OH_MY_ZSH="${HOME}/.oh-my-zsh"
THEME_DIR="$ZSH_CUSTOM/themes/catppuccin-zsh"
THEME_LINK="$OH_MY_ZSH/themes/catppuccin.zsh-theme"
FLAVORS_DIR="$OH_MY_ZSH/themes/catppuccin-flavors"

echo "================================================"
echo "Installing Catppuccin Theme for Zsh"
echo "================================================"

# Check if Oh My Zsh is installed
if [ ! -d "$OH_MY_ZSH" ]; then
    echo "Error: Oh My Zsh is not installed!"
    echo "Please install Oh My Zsh first: https://ohmyz.sh/"
    exit 1
fi

# Check if theme is already installed
if [ -d "$THEME_DIR" ]; then
    echo "Catppuccin theme is already installed at $THEME_DIR"
    read -p "Do you want to reinstall? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 0
    fi
    echo "Removing existing installation..."
    rm -rf "$THEME_DIR"
    rm -f "$THEME_LINK"
    rm -rf "$FLAVORS_DIR"
fi

# Clone the Catppuccin theme repository (JannoTjarks version)
echo "Cloning Catppuccin theme repository..."
git clone https://github.com/JannoTjarks/catppuccin-zsh.git "$THEME_DIR"

# Ensure catppuccin flavors directory exists
echo "Creating flavors directory..."
mkdir -p "$FLAVORS_DIR"

# Create symlink for the main theme
echo "Creating symlink for Catppuccin main theme..."
ln -sf "$THEME_DIR/catppuccin.zsh-theme" "$THEME_LINK"

# Link all flavor themes
echo "Linking Catppuccin flavor themes..."
ln -sf "$THEME_DIR/catppuccin-flavors"/* "$FLAVORS_DIR/"

# Verify installation
if [ -L "$THEME_LINK" ] && [ -e "$THEME_LINK" ]; then
    echo "================================================"
    echo "✓ Catppuccin theme installed successfully!"
    echo "================================================"
    echo ""
    echo "To use the theme, add the following to your ~/.zshrc:"
    echo ""
    echo "  ZSH_THEME=\"catppuccin\""
    echo "  CATPPUCCIN_FLAVOR=\"mocha\""
    echo ""
    echo "Available flavors: latte, frappe, macchiato, mocha"
    echo ""
    echo "Files created:"
    echo "  - Theme directory: $THEME_DIR"
    echo "  - Main theme link: $THEME_LINK"
    echo "  - Flavors directory: $FLAVORS_DIR"
    echo ""
    echo "Then reload your shell with: source ~/.zshrc"
else
    echo "Error: Failed to create theme symlink!"
    exit 1
fi

echo "Installation complete!"