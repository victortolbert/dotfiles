# .zshenv — sourced by ALL zsh invocations (interactive, non-interactive, login, scripts)
# Machine-specific config uses hostname checks so this file works on both milton and peter.

# 1Password service account — headless access on milton only
# On peter and brian, op CLI uses desktop app + Touch ID (default behavior)
if [[ "$(hostname -s)" == "milton" ]]; then
  export OP_BIOMETRIC_UNLOCK_ENABLED=false
  [[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
fi

# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"
