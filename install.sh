#!/usr/bin/env bash
set -euo pipefail

OS="$(uname -s)"

# --- Define packages once ---
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
)

LINUX_EXTRA=(
  binutils
  fonts-cascadia-code
  gnumake
)

MAC_EXTRA=(
  make
)

# --- Install packages ---
if [[ "$OS" == "Linux" ]]; then
  sudo apt update
  sudo apt install -y "${COMMON_PACKAGES[@]}" "${LINUX_EXTRA[@]}"
elif [[ "$OS" == "Darwin" ]]; then
# ensure homebrew exists
  if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"

  brew update
  brew upgrade --quiet "${COMMON_PACKAGES[@]}" "${MAC_EXTRA[@]}"
  brew upgrade --quiet --cask docker font-cascadia-code-pl
fi

# --- Install Starship (if missing) ---
if ! command -v starship &>/dev/null; then
  echo "Installing Starship..."
  curl -fsSL https://starship.rs/install.sh | bash -s -- -y
fi

# --- Install TPM (tmux plugin manager) ---
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  echo "Installing TPM (tmux plugin manager)..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# --- Symlink configs ---
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp -rf "$DOTFILES_DIR/config/shell_aliases.sh" "$HOME/.shell_aliases"
cp -rf "$DOTFILES_DIR/config/git/gitconfig" "$HOME/.gitconfig"
cp -rf "$DOTFILES_DIR/config/git/gitignore_global" "$HOME/.gitignore_global"
cp -rf "$DOTFILES_DIR/config/fish" "$HOME/.config"
cp -rf "$DOTFILES_DIR/config/fzf" "$HOME/.config"
cp -rf "$DOTFILES_DIR/config/tmux" "$HOME/.config"
cp -rf "$DOTFILES_DIR/nvim" "$HOME/.config"
cp -rf "$DOTFILES_DIR/config/starship.toml" "$HOME/.config/starship.toml"

# --- Make Fish the default shell ---
FISH_BIN="$(command -v fish)"

if ! grep -qx "$FISH_BIN" /etc/shells; then
  echo "Adding Fish to /etc/shells..."
  echo "$FISH_BIN" | sudo tee -a /etc/shells
fi

if [ "$SHELL" != "$FISH_BIN" ]; then
  echo "Changing default shell to Fish..."
  chsh -s "$FISH_BIN" || true
fi
