#!/usr/bin/env bash
set -euo pipefail

OS="$(uname -s)"

COMMON_PACKAGES=(
  bat
  coreutils
  docker
  docker-compose
  eza
  fd
  fish
  fzf
  gnupg
  gping
  htop
  jq
  less
  moreutils
  neovim
  openssh
  ripgrep
  tmux
  wget
  asdf
  gawk
  autoconf
)

LINUX_EXTRA=(build-essential binutils gnumake fonts-cascadia-code libyaml-dev zlib1g-dev libffi-dev libgmp-dev rustc)
MAC_EXTRA=(make readline libyaml gmp rust)

if [[ "$OS" == "Linux" ]]; then
    sudo apt update
    sudo apt install -y "${COMMON_PACKAGES[@]}" "${LINUX_EXTRA[@]}"
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
