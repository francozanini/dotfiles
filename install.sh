#!/usr/bin/env bash
set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1" dst="$2"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "Backing up existing $dst to $dst.bak"
    mv "$dst" "$dst.bak"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -sfn "$src" "$dst"
  echo "Linked $dst -> $src"
}

link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
link "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
link "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"
link "$DOTFILES_DIR/ghostty/config.ghostty" "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
link "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
link "$DOTFILES_DIR/zsh/zshenv" "$HOME/.zshenv"
link "$DOTFILES_DIR/zsh/zprofile" "$HOME/.zprofile"
link "$DOTFILES_DIR/zsh/profile" "$HOME/.profile"
link "$DOTFILES_DIR/zsh/p10k.zsh" "$HOME/.p10k.zsh"
link "$DOTFILES_DIR/zsh/franco_aliases" "$HOME/.franco_aliases"
link "$DOTFILES_DIR/zsh/oh-my-zsh-custom/themes/jovial.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/jovial.zsh-theme"

# --- dependencies -----------------------------------------------------------
# Idempotent: each step is skipped if already present.

OMZ_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

clone_plugin() {
  local repo="$1" name="$2"
  if [ -d "$OMZ_CUSTOM/plugins/$name" ]; then
    echo "Already installed: $name"
  else
    git clone --depth 1 "$repo" "$OMZ_CUSTOM/plugins/$name"
  fi
}

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "oh-my-zsh is missing. Install it first: https://ohmyz.sh/#install"
  exit 1
fi

clone_plugin https://github.com/zsh-users/zsh-autosuggestions zsh-autosuggestions
clone_plugin https://github.com/zsh-users/zsh-syntax-highlighting zsh-syntax-highlighting

if [ -d "$OMZ_CUSTOM/themes/powerlevel10k" ]; then
  echo "Already installed: powerlevel10k"
else
  git clone --depth 1 https://github.com/romkatv/powerlevel10k.git "$OMZ_CUSTOM/themes/powerlevel10k"
fi

if command -v zoxide >/dev/null 2>&1; then
  echo "Already installed: zoxide"
elif command -v brew >/dev/null 2>&1; then
  brew install zoxide
else
  echo "WARNING: zoxide missing and no brew found. See https://github.com/ajeetdsouza/zoxide"
fi

if [ -e "$OMZ_CUSTOM/plugins/zsh-history-enquirer" ]; then
  echo "Already installed: zsh-history-enquirer"
elif command -v npm >/dev/null 2>&1; then
  npm install -g zsh-history-enquirer
else
  echo "WARNING: zsh-history-enquirer missing and no npm found."
fi

echo ""
echo "Done."
echo ""
echo "Optional, not handled here (config degrades gracefully if absent):"
echo "  - rust/cargo: https://rustup.rs   (~/.zshenv sources ~/.cargo/env only if it exists)"
