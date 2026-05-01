#!/usr/bin/env bash
set -euo pipefail

OS="$(uname -s)"

# Installed via brew on both Linux and macOS
BREW_PACKAGES=(asdf autoconf bat coreutils eza fd fish fzf gawk gnupg gping htop jq less make moreutils neovim opentofu readline ripgrep rust tmux tree-sitter wget anomalyco/tap/opencode)

# Linux-only: linuxbrew bootstrap, fonts, and asdf source-build headers
APT_PACKAGES=(build-essential fonts-cascadia-code binutils libyaml-dev zlib1g-dev libffi-dev libgmp-dev)

# macOS-only brew formulas and casks
BREW_DARWIN_PACKAGES=(docker docker-compose gmp libyaml)
BREW_DARWIN_CASKS=(docker font-cascadia-code-pl)

PIP_GLOBAL_PACKAGES=(pytest-playwright uv)

if [[ "$OS" == "Linux" ]]; then
    sudo apt update
    sudo apt install -y "${APT_PACKAGES[@]}"
    if ! command -v docker &>/dev/null; then
        curl -fsSL https://get.docker.com | sudo sh
        sudo usermod -aG docker "$USER"
    fi
    BREW_PREFIX="/home/linuxbrew/.linuxbrew"
elif [[ "$OS" == "Darwin" ]]; then
    BREW_PREFIX="/opt/homebrew"
else
    echo "Unsupported OS: $OS" >&2
    exit 1
fi

if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$($BREW_PREFIX/bin/brew shellenv)"

brew update
brew install "${BREW_PACKAGES[@]}" >/dev/null 2>&1 || true

if [[ "$OS" == "Darwin" ]]; then
    brew install "${BREW_DARWIN_PACKAGES[@]}" >/dev/null 2>&1 || true
    brew install --cask "${BREW_DARWIN_CASKS[@]}" >/dev/null 2>&1 || true
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if ! command -v starship &>/dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
fi

if command -v pip &>/dev/null; then
    pip install "${PIP_GLOBAL_PACKAGES[@]}"
else
    echo "pip not found; skipping ${PIP_GLOBAL_PACKAGES[*]}. Install python (asdf install python) then re-run."
fi
