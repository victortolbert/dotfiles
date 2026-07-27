# .zshenv — sourced by ALL zsh invocations (interactive, non-interactive, login, scripts)
# Machine-specific config uses hostname checks so this file works on both milton and peter.

# Keep $PATH free of duplicates. Must stay above anything that edits PATH.
# Prepending an entry that already exists moves it to the front instead of
# adding a second copy, so command resolution is unchanged — only dupes go.
# This also absorbs the case where .zshrc gets sourced twice (VS Code and
# Claude Code terminals inherit an already-built PATH, then run .zshrc again).
typeset -U path PATH

# 1Password service account — headless access on milton only
# On peter and brian, op CLI uses desktop app + Touch ID (default behavior)
if [[ "$(hostname -s)" == "milton" ]]; then
  export OP_BIOMETRIC_UNLOCK_ENABLED=false
  [[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
fi

# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"
