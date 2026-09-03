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

echo "Done."
echo ""
echo "Not handled by this script (install separately if missing on this machine):"
echo "  - oh-my-zsh itself: https://ohmyz.sh/#install"
echo "  - git clone https://github.com/zsh-users/zsh-autosuggestions \${ZSH_CUSTOM:-\$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
echo "  - git clone https://github.com/zsh-users/zsh-syntax-highlighting \${ZSH_CUSTOM:-\$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
echo "  - npm install -g zsh-history-enquirer"
