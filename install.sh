#!/bin/bash
# install.sh — Symlink dotfiles to their expected locations
#
# Usage: ./install.sh
# Run from the dotfiles repo root.
# Creates backups of existing files before symlinking.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link() {
    local src="$1"
    local dest="$2"
    
    if [ ! -f "$src" ]; then
        echo "  SKIP: $src (not found)"
        return
    fi
    
    # Backup existing file if it exists and isn't already a symlink to us
    if [ -f "$dest" ] && [ ! -L "$dest" ]; then
        mkdir -p "$BACKUP_DIR"
        echo "  BACKUP: $dest → $BACKUP_DIR/"
        cp "$dest" "$BACKUP_DIR/$(basename "$dest")"
    fi
    
    # Create parent directory if needed
    mkdir -p "$(dirname "$dest")"
    
    # Create symlink
    ln -sf "$src" "$dest"
    echo "  LINKED: $dest → $src"
}

echo "╔═══════════════════════════════════╗"
echo "║  Dotfiles Install                 ║"
echo "╚═══════════════════════════════════╝"
echo ""
echo "Source: $DOTFILES_DIR"
echo "Backup: $BACKUP_DIR (if needed)"
echo ""

# ZSH
link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link "$DOTFILES_DIR/zsh/.zsh_aliases" "$HOME/.zsh_aliases"

# Ghostty
link "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"

# Git
link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# ZSH custom files (symlink into oh-my-zsh custom dir)
if [ -d "$HOME/.oh-my-zsh/custom" ]; then
    for f in "$DOTFILES_DIR"/zsh/custom/*.zsh; do
        [ -f "$f" ] && link "$f" "$HOME/.oh-my-zsh/custom/$(basename "$f")"
    done
    # Theme
    if [ -f "$DOTFILES_DIR/zsh/custom/themes/cobalt2.zsh-theme" ]; then
        link "$DOTFILES_DIR/zsh/custom/themes/cobalt2.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/cobalt2.zsh-theme"
    fi
fi

echo ""
echo "Done. Restart your shell or run: source ~/.zshrc"
