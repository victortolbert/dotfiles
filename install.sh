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

link_dir() {
    local src="$1"
    local dest="$2"

    if [ ! -d "$src" ]; then
        echo "  SKIP: $src (not found)"
        return
    fi

    # Backup existing dir if it's not already a symlink to us
    if [ -d "$dest" ] && [ ! -L "$dest" ]; then
        mkdir -p "$BACKUP_DIR"
        echo "  BACKUP: $dest → $BACKUP_DIR/"
        cp -R "$dest" "$BACKUP_DIR/$(basename "$dest")"
        rm -rf "$dest"
    elif [ -L "$dest" ]; then
        rm "$dest"
    fi

    mkdir -p "$(dirname "$dest")"
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
link "$DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"
link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
link "$DOTFILES_DIR/zsh/.zsh_aliases" "$HOME/.zsh_aliases"

# Ghostty
link "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"

# Git
link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Custom scripts
for f in "$DOTFILES_DIR"/bin/*; do
    [ -f "$f" ] && link "$f" "$HOME/.local/bin/$(basename "$f")"
done

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

# VS Code (stable)
CODE_USER="$HOME/Library/Application Support/Code/User"
link     "$DOTFILES_DIR/vscode/settings.json"    "$CODE_USER/settings.json"
link     "$DOTFILES_DIR/vscode/keybindings.json" "$CODE_USER/keybindings.json"
link     "$DOTFILES_DIR/vscode/mcp.json"         "$CODE_USER/mcp.json"
link_dir "$DOTFILES_DIR/vscode/snippets"         "$CODE_USER/snippets"

# VS Code Insiders
CODE_INSIDERS_USER="$HOME/Library/Application Support/Code - Insiders/User"
link     "$DOTFILES_DIR/vscode-insiders/settings.json"    "$CODE_INSIDERS_USER/settings.json"
link     "$DOTFILES_DIR/vscode-insiders/keybindings.json" "$CODE_INSIDERS_USER/keybindings.json"
link     "$DOTFILES_DIR/vscode-insiders/mcp.json"         "$CODE_INSIDERS_USER/mcp.json"
link_dir "$DOTFILES_DIR/vscode-insiders/snippets"         "$CODE_INSIDERS_USER/snippets"

# Karabiner-Elements
link "$DOTFILES_DIR/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"

# Zed (only settings + themes — skip prompts/conversations, those are per-machine)
link     "$DOTFILES_DIR/zed/settings.json" "$HOME/.config/zed/settings.json"
link_dir "$DOTFILES_DIR/zed/themes"        "$HOME/.config/zed/themes"

# mise (tool version manager)
link "$DOTFILES_DIR/mise/config.toml" "$HOME/.config/mise/config.toml"

# iTerm2 — plist must not be symlinked; see iterm2/README.md for custom-folder setup.
# First-run seed so iTerm2 has prefs to read before you enable the custom folder:
if [ ! -f "$HOME/Library/Preferences/com.googlecode.iterm2.plist" ]; then
    cp "$DOTFILES_DIR/iterm2/com.googlecode.iterm2.plist" \
       "$HOME/Library/Preferences/com.googlecode.iterm2.plist"
    echo "  SEEDED: com.googlecode.iterm2.plist (see iterm2/README.md to finish setup)"
fi

echo ""
echo "Done. Restart your shell or run: source ~/.zshrc"
echo ""
echo "Next steps on a fresh mac:"
echo "  1. Apply macOS preferences:  ./macos/defaults.sh"
echo "  2. Migrate user fonts:       ~/.local/bin/migrate-fonts"
echo "  3. Restart VS Code / Karabiner to pick up linked configs"
