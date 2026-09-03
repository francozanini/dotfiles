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

echo "Done."
