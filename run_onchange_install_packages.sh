#!/usr/bin/env bash
set -euo pipefail

OS="$(uname -s)"

COMMON_PACKAGES=(
  bat
  coreutils
  eza
  fish
  fzf
  gnupg
  gping
  htop
  jq
  less
  moreutils
  ripgrep
  tmux
  wget
  gawk
  autoconf
  opentofu
)

LINUX_EXTRA=(build-essential binutils fonts-cascadia-code libyaml-dev zlib1g-dev libffi-dev libgmp-dev rustc fd-find ruby-full)
MAC_EXTRA=(make readline libyaml gmp rust fd docker docker-compose asdf neovim)

NPM_GLOBAL_PACKAGES=(tree-sitter-cli)
PIP_GLOBAL_PACKAGES=(pytest-playwright)

if [[ "$OS" == "Linux" ]]; then
    sudo apt update
    sudo apt install -y "${COMMON_PACKAGES[@]}" "${LINUX_EXTRA[@]}"
    sudo snap install nvim --classic
elif [[ "$OS" == "Darwin" ]]; then
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew update
    brew install "${COMMON_PACKAGES[@]}" "${MAC_EXTRA[@]}" >/dev/null 2>&1 || true
    brew install --cask docker font-cascadia-code-pl >/dev/null 2>&1 || true
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if ! command -v starship &>/dev/null; then
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
fi

if command -v npm &>/dev/null; then
    npm install -g "${NPM_GLOBAL_PACKAGES[@]}"
else
    echo "npm not found; skipping ${NPM_GLOBAL_PACKAGES[*]}. Install node (asdf install nodejs) then re-run."
fi

if command -v pip &>/dev/null; then
    pip install "${PIP_GLOBAL_PACKAGES[@]}"
else
    echo "pip not found; skipping ${PIP_GLOBAL_PACKAGES[*]}. Install python (asdf install python) then re-run."
fi

curl -LsSf https://aider.chat/install.sh | sh
