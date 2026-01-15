#!/bin/bash

echo "Setting up Zsh..."

# Install zsh if not present
if ! command -v zsh &> /dev/null; then
    echo "Installing zsh..."
    if [ -f /etc/debian_version ]; then
        sudo apt update && sudo apt install -y zsh
    elif [ -f /etc/redhat-release ]; then
        sudo dnf install -y zsh
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install zsh
    fi
fi

# Change default shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    chsh -s $(which zsh)
    echo "Shell changed. You'll need to log out and back in for this to take effect."
fi

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "Zsh setup complete!"
